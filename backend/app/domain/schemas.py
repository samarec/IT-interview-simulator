from pydantic import BaseModel
from typing import List, Optional, TypeVar, Generic


class TagResponse(BaseModel):
    id: int
    name: str

    class Config:
        from_attributes = True


class TopicResponse(BaseModel):
    id: int
    name: str
    tags: List[TagResponse]
    cards_count: int

    class Config:
        from_attributes = True


# Схема для варианта ответа (таблица answers)
class AnswerResponse(BaseModel):
    id: int
    title: str
    is_correct: bool

    class Config:
        from_attributes = True


# Схема для карточки (таблица cards)
class CardResponse(BaseModel):
    id: int
    topic_id: int
    title: str  # Текст вопроса
    description: Optional[str] = None  # Развёрнутый кейс-объяснение
    answers: List[AnswerResponse] = []  # Варианты ответов для режима экзамена

    class Config:
        from_attributes = True


# Схема входящего запроса для старта тренажёра по выбранным темам
class StartTrainerRequest(BaseModel):
    topic_ids: List[int]


class FAQResponse(BaseModel):
    id: int
    title: str
    description: str

    class Config:
        from_attributes = True


T = TypeVar("T")

class PaginatedResponse(BaseModel, Generic[T]):
    items: List[T]
    total_items: int
    page: int
    size: int
    total_pages: int

class MetaInfo(BaseModel):
    total_questions: int
    current_question_index: int

class SessionQuestionResponse(BaseModel):
    card: CardResponse
    metainfo: MetaInfo

class NextQuestionRequest(BaseModel):
    topic_ids: List[int]
    current_index: int

    