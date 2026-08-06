from typing import List
from fastapi import APIRouter
from app.domain.schemas import TopicResponse, CardResponse, StartTrainerRequest
from app.services.topic_service import get_all_topics
from app.services.card_service import get_cards_by_topics

router = APIRouter(prefix="/topics", tags=["topics"])


@router.get("", response_model=List[TopicResponse])
def read_topics():
    """
    Получить список всех тем для реестра на главной странице.
    """
    return get_all_topics()


@router.post("/cards", response_model=List[CardResponse])
def read_cards_for_topics(payload: StartTrainerRequest):
    """
    Получить список карточек по выбранным темам (POST /api/v1/topics/cards).
    Используется для запуска тренажёра и режимa экзамена.
    """
    return get_cards_by_topics(payload.topic_ids)

