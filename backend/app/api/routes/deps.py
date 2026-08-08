from collections.abc import Generator

from app.db.session import SessionLocale
from sqlalchemy.orm import Session


def get_db() -> Generator[Session, None, None]:
    db = SessionLocale()
    try:
        yield db
    finally:
        db.close()

