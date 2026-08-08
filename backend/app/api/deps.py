from typing import Generator
from app.db.session import SessionLocal


def get_db() -> Generator:
    """
    Зависимость FastAPI для получения сессии БД на время запроса.
    Автоматически закрывает сессию после завершения работы эндпоинта.
    """
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()