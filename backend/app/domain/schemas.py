from typing import List, Optional, TypeVar, Generic
from pydantic import BaseModel, Field


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

class Token(BaseModel):
    access_token: str
    token_type: str = "bearer"

class UserCreate(BaseModel):
    username: str
    email: str
    password: str
    role_id: Optional[int] = None

class UserLogin(BaseModel):
    email: str
    password: str

class UserOut(BaseModel):
    id: int
    username: str
    email: str
    is_active: bool
    role_id: Optional[int] = None

    class Config:
        from_attributes = True

class ProfessionResponse(BaseModel):
    id: int
    name: str
    description: Optional[str] = None

    class Config:
        from_attributes = True

class ProfessionMatchRequest(BaseModel):
    tag_ids: List[int]


class ProfessionMatchResponse(BaseModel):
    correct_profession: ProfessionResponse
    wheel_professions: List[ProfessionResponse]


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
    current_index: int = Field(..., ge=1, description="Индекс текущего вопроса (начиная с 1)")

    