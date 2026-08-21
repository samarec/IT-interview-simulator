from app.api.routes.deps import get_current_user, get_db
from app.domain.models import User
from app.domain.schemas import (
    UserPasswordUpdate,
    UserProfileResponse,
    UserTestsOverviewResponse,
    UserUpdateRequest,
)
from app.services.user_service import (
    get_user_completed_tests,
    get_user_profile,
    update_user_fields,
    update_user_password,
)
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

router = APIRouter(prefix="/users", tags=["users"])

@router.get("/me", response_model=UserProfileResponse)
def read_current_user(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Получить информацию о текущем авторизованном пользователе"""
    try:
        return get_user_profile(db, current_user.id)
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=str(e))


@router.patch("/me", response_model=UserProfileResponse)
def patch_current_user(
    payload: UserUpdateRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Частичное обновление профиля (username, email)
    role_id изменить нельзя
    """
    try:
        user = update_user_fields(
            db,
            user_id=current_user.id,
            username=payload.username,
            email=payload.email,
        )
        return get_user_profile(db, user.id)
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))


@router.post("/me/password", status_code=status.HTTP_200_OK)
def change_password(
    payload: UserPasswordUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Смена пароля текущего пользователя"""
    try:
        update_user_password(
            db,
            user_id=current_user.id,
            current_password=payload.current_password,
            new_password=payload.new_password,
        )
        return {"message": "Пароль успешно изменен"}
    except ValueError as e:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))


@router.get("/me/tests", response_model=UserTestsOverviewResponse)
def read_user_tests(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Получить пройденные тесты, экзамены и сводную статистику."""
    return get_user_completed_tests(db, current_user.id)