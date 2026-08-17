from typing import List, Optional
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.api.routes.deps import get_db, get_optional_current_user, get_current_user
from app.domain.models import User
from app.domain.schemas import TagWithSelectionResponse, UserTagsUpdateRequest
from app.services import tag_service

router = APIRouter(prefix="/tags", tags=["tags"])

@router.get("", response_model=List[TagWithSelectionResponse])
def get_all_tags(
    db: Session = Depends(get_db),
    current_user: Optional[User] = Depends(get_optional_current_user)
):
    """Получить перечень всех тегов."""
    return tag_service.get_tags_with_selection(db, current_user)

@router.post("/me", response_model=List[TagWithSelectionResponse])
def update_my_tags(
    payload: UserTagsUpdateRequest,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """Сохранить теги для текущего пользователя."""
    return tag_service.update_user_tags(db, current_user, payload.tag_ids)

