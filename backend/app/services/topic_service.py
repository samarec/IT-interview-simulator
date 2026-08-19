from typing import Dict, List, Tuple, Optional
from sqlalchemy import func
from sqlalchemy.orm import Session, selectinload

from app.domain.models import FAQ, Card, Test, Topic, User, UserTopicCounter, CardType
from app.domain.schemas import (
    AnswerResponse,
    CardResponse,
    TagResponse,
    TopicResponse,
    FAQResponse
)


def get_passed_counts_map(db: Session, topic_ids: Optional[List[int]] = None) -> Dict[int, int]:
    query = db.query(
        UserTopicCounter.topic_id,
        func.count(UserTopicCounter.user_id),
    ).filter(UserTopicCounter.completed_count > 0)

    if topic_ids is not None:
        if not topic_ids:
            return {}
        query = query.filter(UserTopicCounter.topic_id.in_(topic_ids))

    return {
        topic_id: count
        for topic_id, count in query.group_by(UserTopicCounter.topic_id).all()
    }


def build_topic_response(
    topic: Topic,
    completed_count: int = 0,
    passed_count: int = 0,
) -> TopicResponse:
    description = None
    if topic.cards:
        first_card = min(topic.cards, key=lambda card: card.id)
        description = first_card.description

    return TopicResponse(
        id=topic.id,
        name=topic.name,
        code=topic.code,
        tags=[TagResponse(id=tag.id, name=tag.name) for tag in topic.tags],
        cards_count=len(topic.cards),
        completed_count=completed_count,
        passed_count=passed_count,
        description=description,
    )


def get_all_topics(db: Session, user_id: Optional[int] = None) -> List[TopicResponse]:
    """
    Возвращает список всех тем. Если передан user_id, подтягивает счетчики прохождения.
    """
    topics = db.query(Topic).options(
        selectinload(Topic.tags),
        selectinload(Topic.cards)
    ).all()

    # Словарь счетчиков {topic_id: completed_count}, если юзер авторизован
    counters_map = {}
    if user_id:
        counters = db.query(UserTopicCounter).filter(UserTopicCounter.user_id == user_id).all()
        counters_map = {c.topic_id: c.completed_count for c in counters}

    passed_map = get_passed_counts_map(db)

    return [
        build_topic_response(
            topic,
            counters_map.get(topic.id, 0),
            passed_map.get(topic.id, 0),
        )
        for topic in topics
    ]


def get_cards_by_topics(db: Session, topic_ids: List[int]) -> List[CardResponse]:
    if not topic_ids:
        return []

    cards = db.query(Card).options(
        selectinload(Card.answers)
    ).filter(Card.topic_id.in_(topic_ids)).all()

    return [
        CardResponse(
            id=card.id,
            topic_id=card.topic_id,
            title=card.title,
            description=card.description,
            answers=[AnswerResponse(id=a.id, title=a.title, is_correct=a.is_correct) for a in card.answers],
            card_type=getattr(db.query(CardType).get(card.card_type_id), 'name', ''),
        )
        for card in cards
    ]


def get_all_faqs(db: Session) -> List[FAQResponse]:
    faqs = db.query(FAQ).all()
    return [FAQResponse(id=faq.id, title=faq.title, description=faq.description) for faq in faqs]


def get_paginated_topics(db: Session, page: int, size: int, user_id: Optional[int] = None) -> Tuple[List[Topic], int, dict]:
    """
    Возвращает список тем с пагинацией, их количество и мапу счетчиков для пользователя.
    """
    total_items = db.query(Topic).count()

    topics = db.query(Topic).options(
        selectinload(Topic.tags),
        selectinload(Topic.cards)
    ).order_by(Topic.id).offset((page - 1) * size).limit(size).all()

    counters_map = {}
    if user_id and topics:
        topic_ids = [t.id for t in topics]
        counters = db.query(UserTopicCounter).filter(
            UserTopicCounter.user_id == user_id,
            UserTopicCounter.topic_id.in_(topic_ids)
        ).all()
        counters_map = {c.topic_id: c.completed_count for c in counters}

    return topics, total_items, counters_map


def get_session_question(db: Session, topic_ids: List[int], current_index: int) -> Tuple[Card, int]:
    total_questions = db.query(Card).filter(Card.topic_id.in_(topic_ids)).count()

    card = db.query(Card).options(
        selectinload(Card.answers)
    ).filter(
        Card.topic_id.in_(topic_ids)
    ).order_by(
        Card.id
    ).offset(current_index - 1).limit(1).first()

    return card, total_questions


def complete_topic_session(db: Session, user_id: int, topic_id: int):
    """
    Увеличивает счетчик прохождения темы для конкретного пользователя.
    """
    topic = db.query(Topic).filter(Topic.id == topic_id).first()
    if not topic:
        raise ValueError("Тема не найдена.")

    counter = db.query(UserTopicCounter).filter(
        UserTopicCounter.user_id == user_id,
        UserTopicCounter.topic_id == topic_id
    ).first()

    if counter:
        counter.completed_count += 1
    else:
        counter = UserTopicCounter(user_id=user_id, topic_id=topic_id, completed_count=1)
        db.add(counter)

    db.commit()
    return counter

def get_counters(db: Session) -> dict:

    questions_count = db.query(Card).count()
    topics_count = db.query(Topic).count()
    tests_count = db.query(Test).count()
    users_count = db.query(User).count()

    return {
        "questions": questions_count,
        "topics": topics_count,
        "tests": tests_count,
        "users": users_count,
    }