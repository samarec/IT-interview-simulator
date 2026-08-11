from typing import List
from fastapi import APIRouter, Depends, HTTPException

from app.api.deps import get_db
from app.domain.schemas import ProfessionMatchRequest, ProfessionMatchResponse
from app.services.profession_service import match_profession
from sqlalchemy.orm import Session

router = APIRouter(prefix="/professions", tags=["professions"])

@router.post("/match", response_model=ProfessionMatchResponse)
def match_professions(
    pauload: ProfessionMatchRequest,
    db: Session = Depends(get_db),
):
    if not pauload.tag_ids:
        raise HTTPException(status_code=400, detail="Необходимо выбрать хотя бы один тег.")

    unique_tag_ids = list(set(pauload.tag_ids))

    return match_profession(db, unique_tag_ids)

# по 5 выбранным тегам пользователя идет подбор
# 1 правильную профессию по макс.количеству совпадающих тегов
# 5 неправильных профессий для колеса
# и ЕСЛИ совпадений нет, то правльная профессия выбирается случайно