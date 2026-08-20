from typing import List, Optional

from app.domain.models import Test, User, UserTestResult
from app.domain.schemas import CompletedTestResponse, UserProfileResponse
from app.services.auth_service import get_password_hash, verify_password
from sqlalchemy.orm import Session


def get_user_profile(db: Session, user_id: int) -> UserProfileResponse:
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise ValueError("Пользователь найден.")
    return UserProfileResponse(
        id=user.id,
        username=user.username,
        email=user.email,
        is_active=user.is_active,
        role_id=user.role_id,
        created_at=user.created_at,
    )

def update_user_fields(
        db: Session,
        user_id: int,
        username: Optional[str] = None,
        email: Optional[str] = None,
) -> User:
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise ValueError("Пользователь не найден.")

    if username is not None:
        existing = db.query(User).filter(User.username == username, User.id != user_id).first()
        if existing:
            raise ValueError("Username уже занят.")
        user.username = username

    if email is not None:
        existing = db.query(User).filter(User.email == email, User.id != user_id).first()
        if existing:
            raise ValueError("Email уже зарегистрирован.")
        user.email = email

    db.commit()
    db.refresh(user)
    return user

def update_user_password(
    db: Session,
    user_id: int,
    current_password: str,
    new_password: str,
) -> None:
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise ValueError("Пользователь не найден.")

    if not verify_password(current_password, user.password_hash):
        raise ValueError("Текущий пароль наверен.")

    user.password_hash = get_password_hash(new_password)
    db.commit()

def get_user_completed_tests(db: Session, user_id: int) -> List[CompletedTestResponse]:
    results = (
        db.query(UserTestResult)
        .filter(UserTestResult.user_id == user_id)
        .order_by(UserTestResult.completed_at.desc())
        .all()
    )

    return [
        CompletedTestResponse(
            id=r.id,
            test_id=r.test_id,
            test_name=r.test.name if r.test else "Неизвестный тест",
            score=r.score,
            max_score=r.max_score,
            passed=r.passed,
            completed_at=r.completed_at,
        )
        for r in results
    ]