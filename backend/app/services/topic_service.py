from typing import List
from app.domain.schemas import TagResponse, TopicResponse, CardResponse, AnswerResponse

# Mock-данные тем для главной страницы
MOCK_TOPICS = [
    TopicResponse(
        id=1,
        name="HTTP-статусы",
        tags=[
            TagResponse(id=1, name="Сети"),
            TagResponse(id=2, name="Web"),
        ],
        cards_count=2,
    ),
    TopicResponse(
        id=2,
        name="Основы Git",
        tags=[
            TagResponse(id=3, name="DevOps"),
            TagResponse(id=4, name="Инструменты"),
        ],
        cards_count=1,
    ),
    TopicResponse(
        id=3,
        name="Базовый SQL",
        tags=[
            TagResponse(id=5, name="Базы данных"),
        ],
        cards_count=1,
    ),
]

# Mock-данные карточек
MOCK_CARDS = [
    CardResponse(
        id=1,
        topic_id=1,
        title="Чем HTTP 401 отличается от 403?",
        description="401 Unauthorized — клиент не аутентифицирован. 403 Forbidden — клиент известен, но доступ запрещён.",
        answers=[
            AnswerResponse(id=1, title="401 — не аутентифицирован, 403 — доступ запрещён", is_correct=True),
            AnswerResponse(id=2, title="401 — ошибка сервера, 403 — ресурс не найден", is_correct=False),
            AnswerResponse(id=3, title="Это идентичные статусы", is_correct=False),
        ]
    ),
    CardResponse(
        id=2,
        topic_id=1,
        title="Что означает статус HTTP 500 Internal Server Error?",
        description="Указывает на то, что на стороне сервера произошла непредвиденная ошибка.",
        answers=[
            AnswerResponse(id=4, title="Сервер временно недоступен", is_correct=False),
            AnswerResponse(id=5, title="Внутренняя ошибка сервера", is_correct=True),
            AnswerResponse(id=6, title="Запрос клиента содержал ошибку", is_correct=False),
        ]
    ),
    CardResponse(
        id=3,
        topic_id=2,
        title="В чём разница между git fetch и git pull?",
        description="git fetch только скачивает изменения, git pull скачивает и сразу сливает (git merge) их.",
        answers=[
            AnswerResponse(id=7, title="git fetch сливает изменения, git pull только скачивает", is_correct=False),
            AnswerResponse(id=8, title="git pull = git fetch + git merge", is_correct=True),
            AnswerResponse(id=9, title="Между ними нет никакой разницы", is_correct=False),
        ]
    ),
    CardResponse(
        id=4,
        topic_id=3,
        title="Чем WHERE отличается от HAVING в SQL?",
        description="WHERE фильтрует строки до GROUP BY, HAVING — после группировки.",
        answers=[
            AnswerResponse(id=10, title="WHERE фильтрует до GROUP BY, HAVING — после", is_correct=True),
            AnswerResponse(id=11, title="HAVING применяется только в UPDATE", is_correct=False),
            AnswerResponse(id=12, title="Это синонимы", is_correct=False),
        ]
    ),
]


def get_all_topics() -> List[TopicResponse]:
    """Возвращает список всех доступных тем с тегами и количеством карточек."""
    return MOCK_TOPICS


def get_cards_by_topics(topic_ids: List[int]) -> List[CardResponse]:
    """Фильтирует и возвращает список карточек по переданным ID тем."""
    if not topic_ids:
        return []

    return [card for card in MOCK_CARDS if card.topic_id in topic_ids]