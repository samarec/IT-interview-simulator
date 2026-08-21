from typing import Optional

from sqlalchemy.orm import Session, selectinload

from app.domain.models import Card, Profession, Test, TestCard, Topic, User, UserTestResult
from app.domain.schemas import CompletedTestResponse, UserProfileResponse, UserTestsOverviewResponse
from app.services.auth_service import get_password_hash, verify_password
from app.services.test_service import _cards_count, _test_tags


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


def _result_mode(result: UserTestResult) -> str:
    return result.mode if result.mode in {"training", "exam"} else "training"


def _serialize_completed(result: UserTestResult) -> CompletedTestResponse:
    test = result.test
    return CompletedTestResponse(
        id=result.id,
        test_id=result.test_id,
        test_name=test.name if test else "Неизвестный тест",
        test_code=test.code if test else None,
        mode=_result_mode(result),
        score=result.score,
        max_score=result.max_score,
        passed=bool(result.passed),
        cards_count=_cards_count(test) if test else (result.max_score or 0),
        duration_minutes=(test.duration_minutes or 5) if test else 5,
        tags=_test_tags(test) if test else [],
        completed_at=result.completed_at,
    )


def get_user_completed_tests(db: Session, user_id: int) -> UserTestsOverviewResponse:
    results = (
        db.query(UserTestResult)
        .options(
            selectinload(UserTestResult.test)
            .selectinload(Test.card_links)
            .selectinload(TestCard.card)
            .selectinload(Card.topic)
            .selectinload(Topic.tags),
            selectinload(UserTestResult.test).selectinload(Test.profession).selectinload(Profession.tags),
        )
        .filter(UserTestResult.user_id == user_id)
        .order_by(UserTestResult.completed_at.desc())
        .all()
    )

    latest: dict[tuple[int, str], UserTestResult] = {}
    for result in results:
        key = (result.test_id, _result_mode(result))
        if key not in latest:
            latest[key] = result

    items = [_serialize_completed(result) for result in latest.values()]
    tests_completed = len({item.test_id for item in items if item.mode != "exam"})
    exams_passed = len({item.test_id for item in items if item.mode == "exam" and item.passed})
    percents = [
        item.score / item.max_score * 100
        for item in items
        if item.score is not None and item.max_score
    ]
    average_percent = round(sum(percents) / len(percents)) if percents else 0

    return UserTestsOverviewResponse(
        tests_completed=tests_completed,
        exams_passed=exams_passed,
        average_percent=average_percent,
        items=items,
    )
