from typing import List
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.api.deps import get_db
from app.domain.schemas import CardResponse, StartTrainerRequest, TopicResponse
from app.services.topic_service import get_all_topics, get_cards_by_topics

router = APIRouter(prefix="/topics", tags=["topics"])


@router.get("", response_model=List[TopicResponse])
def read_topics(db: Session = Depends(get_db)):
    """
    Получить список всех тем для реестра на главной странице.
    """
    return get_all_topics(db)


@router.post("/cards", response_model=List[CardResponse])
def read_cards_for_topics(
    payload: StartTrainerRequest,
    db: Session = Depends(get_db)
):
    """
    Получить список карточек по выбранным темам (POST /api/v1/topics/cards).
    Используется для запуска тренажёра и режима экзамена.
    """
    return get_cards_by_topics(db, payload.topic_ids)