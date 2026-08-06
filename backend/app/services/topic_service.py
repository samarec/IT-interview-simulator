from typing import List
from sqlalchemy.orm import Session, selectinload

from app.domain.models import Card, Topic
from app.domain.schemas import (
    AnswerResponse,
    CardResponse,
    TagResponse,
    TopicResponse,
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