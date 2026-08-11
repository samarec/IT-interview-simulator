from typing import List, Tuple
from sqlalchemy.orm import Session, selectinload

from app.domain.models import FAQ, Card, Topic
from app.domain.schemas import (
    AnswerResponse,
    CardResponse,
    TagResponse,
    TopicResponse,
    FAQResponse
)


def get_all_topics(db: Session) -> List[TopicResponse]:
    """
    Возвращает список всех доступных тем из PostgreSQL
    с подгруженными тегами и рассчитанным количеством карточек.
    """
    # Запрашиваем темы, оптимизированно подгружая связанные теги и карточки
    topics = db.query(Topic).options(
        selectinload(Topic.tags),
        selectinload(Topic.cards)
    ).all()

    return [
        TopicResponse(
            id=topic.id,
            name=topic.name,
            tags=[TagResponse(id=tag.id, name=tag.name) for tag in topic.tags],
            cards_count=len(topic.cards),
        )
        for topic in topics
    ]


def get_cards_by_topics(db: Session, topic_ids: List[int]) -> List[CardResponse]:
    """
    Фильтрует и возвращает список карточек с вариантами ответов
    по переданным ID тем из PostgreSQL.
    """
    if not topic_ids:
        return []

    # Запрашиваем карточки, фильтруя по ID тем и подгружая варианты ответов
    cards = db.query(Card).options(
        selectinload(Card.answers)
    ).filter(Card.topic_id.in_(topic_ids)).all()

    return [
        CardResponse(
            id=card.id,
            topic_id=card.topic_id,
            title=card.title,
            description=card.description,
            answers=[
                AnswerResponse(
                    id=answer.id,
                    title=answer.title,
                    is_correct=answer.is_correct
                )
                for answer in card.answers
            ],
        )
        for card in cards
    ]


def get_all_faqs(db: Session) -> List[FAQResponse]:
    """Возвращает список всех часто задаваемых вопросов из PostgreSQL."""
    faqs = db.query(FAQ).all()
    return [
        FAQResponse(id=faq.id, title=faq.title, description=faq.description)
        for faq in faqs
    ]


def get_paginated_topics(db: Session, page: int, size: int) -> Tuple[List[Topic], int]:
    """
    Возвращает список тем с пагинацией и общее количество тем в БД.
    """
    total_items = db.query(Topic).count()

    topics = db.query(Topic).options(
        selectinload(Topic.tags),
        selectinload(Topic.cards)
    ).offset((page - 1) * size).limit(size).all()

    return topics, total_items


def get_session_question(db: Session, topic_ids: List[int], current_index: int) -> Tuple[Card, int]:
    """
    Возвращает конкретную карточку по индексу и общее число вопросов в выбранных темах.
    """
    # Считаем общее количество карточек по выбранным темам
    total_questions = db.query(Card).filter(Card.topic_id.in_(topic_ids)).count()

    # Достаем нужную карточку, "пропуская" предыдущие с помощью offset
    card = db.query(Card).options(
        selectinload(Card.answers)
    ).filter(
        Card.topic_id.in_(topic_ids)
    ).offset(current_index - 1).limit(1).first()

    return card, total_questions

