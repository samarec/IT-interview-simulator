from typing import List
from app.domain.schemas import TagResponse, TopicResponse


def get_all_topics() -> List[TopicResponse]:
    """Возвращает список всех доступных тем с тегами и количеством карточек.

    Временные mock-данные до подключения PostgreSQL.
    """
    return [
        TopicResponse(
            id=1,
            name="HTTP-статусы",
            tags=[
                TagResponse(id=1, name="Сети"),
                TagResponse(id=2, name="Web"),
            ],
            cards_count=10,
        ),
        TopicResponse(
            id=2,
            name="Основы Git",
            tags=[
                TagResponse(id=3, name="DevOps"),
                TagResponse(id=4, name="Инструменты"),
            ],
            cards_count=8,
        ),
        TopicResponse(
            id=3,
            name="Базовый SQL",
            tags=[
                TagResponse(id=5, name="Базы данных"),
            ],
            cards_count=12,
        ),
    ]

