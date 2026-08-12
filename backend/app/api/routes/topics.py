import math
from typing import List
from fastapi import APIRouter, Depends, HTTPException, status, Query
from sqlalchemy.orm import Session, selectinload

from app.api.routes.deps import get_db
from app.domain.models import Topic
from app.domain.schemas import (
    CardResponse,
    FAQResponse,
    StartTrainerRequest,
    TagResponse,
    TopicResponse,
    PaginatedResponse,
    SessionQuestionResponse,
    NextQuestionRequest,
    MetaInfo,
    AnswerResponse
)
from app.services.topic_service import (
    get_all_faqs,
    get_all_topics,
    get_cards_by_topics,
    get_paginated_topics,
    get_session_question
)

router = APIRouter(prefix="/topics", tags=["topics"])


@router.get("", response_model=List[TopicResponse])
def read_topics(db: Session = Depends(get_db)):
    """
    Получить список всех тем для реестра на главной странице.
    """
    return get_all_topics(db)


@router.get("/faq", response_model=List[FAQResponse], tags=["faq"])
def read_faqs(db: Session = Depends(get_db)):
    """
    Получить список часто задаваемых вопросов (FAQ).
    """
    return get_all_faqs(db)


@router.get("/paginated", response_model=PaginatedResponse[TopicResponse])
def read_topics_paginated(
    page: int = Query(1, ge=1, description="Номер текущей страницы"),
    size: int = Query(10, ge=1, le=100, description="Количество элементов на странице"),
    db: Session = Depends(get_db)
):
    """
    Получить список тем с постраничной навигацией (пагинацией).
    """
    topics, total_items = get_paginated_topics(db, page, size)
    total_pages = math.ceil(total_items / size) if size else 0

    topic_responses = [
        TopicResponse(
            id=topic.id,
            name=topic.name,
            tags=[TagResponse(id=tag.id, name=tag.name) for tag in topic.tags],
            cards_count=len(topic.cards),
        )
        for topic in topics
    ]

    return PaginatedResponse(
        items=topic_responses,
        total_items=total_items,
        page=page,
        size=size,
        total_pages=total_pages
    )


@router.get("/{topic_id}", response_model=TopicResponse)
def read_topic_by_id(topic_id: int, db: Session = Depends(get_db)):
    """
    Получить подробную информацию по конкретной теме.
    """
    topic = (
        db.query(Topic)
        .options(selectinload(Topic.tags), selectinload(Topic.cards))
        .filter(Topic.id == topic_id)
        .first()
    )

    if not topic:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Тема с ID {topic_id} не найдена.",
        )

    return TopicResponse(
        id=topic.id,
        name=topic.name,
        tags=[TagResponse(id=tag.id, name=tag.name) for tag in topic.tags],
        cards_count=len(topic.cards),
    )


@router.post("/cards", response_model=List[CardResponse])
def read_cards_for_topics(
    payload: StartTrainerRequest, db: Session = Depends(get_db)
):
    """
    Получить список карточек по выбранным темам.
    """
    if not payload.topic_ids:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Необходимо выбрать хотя бы одну тему для старта.",
        )

    return get_cards_by_topics(db, payload.topic_ids)


@router.post("/session/question", response_model=SessionQuestionResponse)
def read_session_question(
    payload: NextQuestionRequest,
    db: Session = Depends(get_db)
):
    """
    Получить конкретный вопрос для тренажёра по номеру (current_index) и ID тем, вместе с metainfo.
    """
    if not payload.topic_ids:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Необходимо выбрать хотя бы одну тему для старта."
        )

    card, total_questions = get_session_question(db, payload.topic_ids, payload.current_index)

    if not card:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Вопрос с таким индексом не найден."
        )

    card_resp = CardResponse(
        id=card.id,
        topic_id=card.topic_id,
        title=card.title,
        description=card.description,
        answers=[
            AnswerResponse(id=a.id, title=a.title, is_correct=a.is_correct)
            for a in card.answers
        ]
    )

    metainfo = MetaInfo(
        total_questions=total_questions,
        current_question_index=payload.current_index
    )

    return SessionQuestionResponse(card=card_resp, metainfo=metainfo)

