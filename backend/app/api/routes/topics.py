from typing import List
from fastapi import APIRouter
from app.domain.schemas import TopicResponse
from app.services.topic_service import get_all_topics

router = APIRouter(prefix="/topics", tags=["topics"])


@router.get("", response_model=List[TopicResponse])
def read_topics():
    """
    Получить список всех тем для реестра на главной странице.
    """
    return get_all_topics()

