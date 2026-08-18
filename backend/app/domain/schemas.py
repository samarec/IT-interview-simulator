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
    code: Optional[str] = None
    tags: List[TagResponse]
    cards_count: int
    completed_count: int = 0
    passed_count: int = 0
    description: Optional[str] = None

    class Config:
        from_attributes = True


# Схема для варианта ответа (таблица answers)
class AnswerResponse(BaseModel):
    id: int
    title: str
    is_correct: Optional[bool] = None

    class Config:
        from_attributes = True


# Схема для карточки (таблица cards)
class CardResponse(BaseModel):
    id: int
    topic_id: int
    title: str  # Текст вопроса
    description: Optional[str] = None  # Развёрнутый кейс-объяснение
    answers: List[AnswerResponse] = []  # Варианты ответов для режима экзамена
    card_type: str

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

class UserUpdate(BaseModel):
    username: Optional[str] = None
    email: Optional[str] = None
    password: Optional[str] = None

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


class TestResponse(BaseModel):
    id: int
    name: str
    code: str
    description: Optional[str] = None
    duration_minutes: int = 5
    cards_count: int
    profession_id: Optional[int] = None

    class Config:
        from_attributes = True

class CountersResponse(BaseModel):
    questions: int
    topics: int
    tests: int
    users: int

class TestDetailResponse(TestResponse):
    cards: List[CardResponse] = []


class TestAnswerSubmit(BaseModel):
    card_id: int
    answer_id: int


class TestSubmitRequest(BaseModel):
    answers: List[TestAnswerSubmit]


class TestAnswerResult(BaseModel):
    card_id: int
    selected_answer_id: Optional[int] = None
    correct_answer_id: Optional[int] = None
    is_correct: bool


class TestSubmitResponse(BaseModel):
    test: TestResponse
    correct_count: int
    total: int
    passed: bool
    results: List[TestAnswerResult]


class TagWithSelectionResponse(BaseModel):
    id: int
    name: str
    is_selected: bool

    class Config:
        from_attributes = True

class UserTagsUpdateRequest(BaseModel):
    tag_ids: List[int]


