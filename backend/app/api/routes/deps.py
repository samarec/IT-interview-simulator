from collections.abc import Generator

from app.db.session import SessionLocal
from sqlalchemy.orm import Session


def get_db() -> Generator[Session, None, None]:
"""
Зависимость FastAPI для получения сессии БД на время запроса.
Автоматически закрывает сессию после завершения работы эндпоинта.
"""
    db = SessionLocale()
    try:
        yield db
    finally:
        db.close()

