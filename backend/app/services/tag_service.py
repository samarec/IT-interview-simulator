from typing import List, Optional
from sqlalchemy.orm import Session
from app.domain.models import Tag, User
from app.domain.schemas import TagWithSelectionResponse


def get_tags_with_selection(db: Session, user: Optional[User] = None) -> List[TagWithSelectionResponse]:
    """Возвращает все активные теги. Если передан юзер, отмечает выбранные им."""
    all_tags = db.query(Tag).filter(Tag.is_active == True).all()

    # Если пользователь гость, множество выбранных тегов пустое
    user_tag_ids = set(tag.id for tag in user.tags) if user else set()

    return [
        TagWithSelectionResponse(
            id=tag.id,
            name=tag.name,
            is_selected=(tag.id in user_tag_ids)
        )
        for tag in all_tags
    ]


def update_user_tags(db: Session, user: User, tag_ids: List[int]) -> List[TagWithSelectionResponse]:
    """Привязывает переданные ID тегов к пользователю и возвращает обновленный список."""
    # Получаем только существующие и активные теги из запроса
    valid_tags = db.query(Tag).filter(Tag.id.in_(tag_ids), Tag.is_active == True).all()

    user.tags = valid_tags
    db.commit()
    db.refresh(user)

    return get_tags_with_selection(db, user)

