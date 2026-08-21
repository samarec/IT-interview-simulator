from typing import List, Optional
import math

from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.orm import Session

from app.api.routes.deps import get_db, get_optional_current_user
from app.domain.models import User
from app.domain.schemas import (
    TestDetailResponse,
    TestResponse,
    TestSubmitRequest,
    TestSubmitResponse,
    PaginatedResponse
)
from app.services.test_service import (
    build_test_response,
    get_all_tests,
    get_test_by_code,
    get_test_detail,
    submit_test,
)

router = APIRouter(prefix="/tests", tags=["tests"])


@router.get("", response_model=PaginatedResponse[TestResponse])
def read_tests(
    search: Optional[str] = Query(None, description="Поиск по названию или описанию"),
    sort_by: Optional[str] = Query(None, description="Сортировка: 'newest' или 'popular'"),
    tags: List[int] = Query(None, description="Список ID тегов для фильтрации"),
    page: int = Query(1, ge=1, description="Номер текущей страницы"),
    size: int = Query(10, ge=1, le=100, description="Количество элементов на странице"),
    db: Session = Depends(get_db)
):
    """
        Получить список всех тестов с поддержкой поиска, фильтрации по тегам, сортировки и постраничной навигации.
        """
    # Теперь сервис возвращает кортеж из двух значений
    test_responses, total_items = get_all_tests(db, search=search, sort_by=sort_by, tags=tags, page=page, size=size)

    # Считаем количество страниц
    total_pages = math.ceil(total_items / size) if size else 0

    return PaginatedResponse(
        items=test_responses,
        total_items=total_items,
        page=page,
        size=size,
        total_pages=total_pages
    )

@router.get("/{code}", response_model=TestResponse)
def read_test(code: str, db: Session = Depends(get_db)):
    test = get_test_by_code(db, code)
    if not test:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Тест не найден.")
    return build_test_response(db, test)


@router.get("/{code}/cards", response_model=TestDetailResponse)
def read_test_cards(
    code: str,
    mode: str = Query("training", pattern="^(training|exam)$"),
    db: Session = Depends(get_db),
):
    test = get_test_by_code(db, code)
    if not test:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Тест не найден.")
    if not test.card_links:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="В тесте пока нет вопросов.")
    return get_test_detail(db, test, reveal_correct=(mode == "training"))


@router.post("/{code}/submit", response_model=TestSubmitResponse)
def finish_test(
    code: str,
    payload: TestSubmitRequest,
    db: Session = Depends(get_db),
    current_user: Optional[User] = Depends(get_optional_current_user),
):
    test = get_test_by_code(db, code)
    if not test:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Тест не найден.")
    user_id = current_user.id if current_user else None
    mode = payload.mode if payload.mode in {"training", "exam"} else "training"
    return submit_test(db, test, payload.answers, user_id=user_id, mode=mode)

