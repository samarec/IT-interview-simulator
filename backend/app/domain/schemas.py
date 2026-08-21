from datetime import datetime
from typing import Generic, List, Optional, TypeVar

from pydantic import BaseModel, Field, field_validator


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


class AnswerResponse(BaseModel):
    id: int
    title: str
    is_correct: Optional[bool] = None

    class Config:
        from_attributes = True


class CardResponse(BaseModel):
    id: int
    topic_id: int
    title: str  # Текст вопроса
    description: Optional[str] = None  # Развёрнутый кейс-объяснение
    answers: List[AnswerResponse] = []  # Варианты ответов для режима экзамена
    card_type: str

    class Config:
        from_attributes = True


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
    username: str = Field(min_length=2, max_length=100)
    email: str = Field(min_length=3, max_length=255)
    password: str = Field(min_length=6, max_length=72)
    role_id: Optional[int] = None

    @field_validator("username", "email", mode="before")
    @classmethod
    def strip_text(cls, value: object) -> object:
        return value.strip() if isinstance(value, str) else value

    @field_validator("email")
    @classmethod
    def normalize_email(cls, value: str) -> str:
        if "@" not in value or value.startswith("@") or value.endswith("@"):
            raise ValueError("Введите корректный email")
        return value.lower()


class UserLogin(BaseModel):
    email: str = Field(min_length=3, max_length=255)
    password: str = Field(min_length=1, max_length=72)

    @field_validator("email", mode="before")
    @classmethod
    def strip_email(cls, value: object) -> object:
        return value.strip() if isinstance(value, str) else value

    @field_validator("email")
    @classmethod
    def normalize_email(cls, value: str) -> str:
        return value.lower()

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
    tags: List[TagResponse] = []

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
    difficulty: Optional[str] = None
    tags: List[TagResponse] = []
    passed_count: int = 0

    class Config:
        from_attributes = True


class TestDetailResponse(TestResponse):
    cards: List[CardResponse] = []


class TestAnswerSubmit(BaseModel):
    card_id: int
    answer_id: int


class TestSubmitRequest(BaseModel):
    answers: List[TestAnswerSubmit]
    mode: Optional[str] = "training"


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


class CountersResponse(BaseModel):
    questions: int
    topics: int
    tests: int
    users: int


class UserProfileResponse(BaseModel):
    id: int
    username: str
    email: str
    is_active: bool
    role_id: Optional[int] = None
    created_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class UserUpdateRequest(BaseModel):
    username: Optional[str] = None
    email: Optional[str] = None


class UserPasswordUpdate(BaseModel):
    current_password: str
    new_password: str


class CompletedTestResponse(BaseModel):
    id: int
    test_id: int
    test_name: str
    test_code: Optional[str] = None
    mode: str = "training"
    score: Optional[int] = None
    max_score: Optional[int] = None
    passed: bool
    cards_count: int = 0
    duration_minutes: int = 5
    tags: List[TagResponse] = []
    completed_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class UserTestsOverviewResponse(BaseModel):
    tests_completed: int = 0
    exams_passed: int = 0
    average_percent: int = 0
    items: List[CompletedTestResponse] = []

