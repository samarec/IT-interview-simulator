from typing import List
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session, selectinload

from app.api.deps import get_db
from app.domain.models import Topic
from app.domain.schemas import (
    CardResponse,
    FAQResponse,
    StartTrainerRequest,
    TagResponse,
    TopicResponse,
)
from app.services.topic_service import (
    get_all_faqs,
    get_all_topics,
    get_cards_by_topics,
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

