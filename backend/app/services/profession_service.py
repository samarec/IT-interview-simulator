import random
from typing import List, Tuple
from fastapi import HTTPException  # Добавлен импорт HTTPException

from app.domain.models import Profession
from app.domain.schemas import ProfessionMatchResponse, ProfessionResponse, TagResponse
from sqlalchemy.orm import Session, selectinload


def match_profession(db: Session, tag_ids: List[int]) -> ProfessionMatchResponse:
    professions = db.query(Profession).options(selectinload(Profession.tags)).all()

    if not professions:
        raise HTTPException(status_code=404, detail="В базе данных нет профессий.")

    scored: List[Tuple[Profession, int]] = []
    for prof in professions:
        prof_tag_ids = {tag.id for tag in prof.tags}
        score = len(prof_tag_ids & set(tag_ids))
        scored.append((prof, score))

    max_score = max(score for _, score in scored)

    if max_score > 0:
        best_professions = [prof for prof, score in scored if score == max_score]
        correct_profession = random.choice(best_professions)
    else:
        correct_profession = random.choice(professions)

    other_professions = [p for p in professions if p.id != correct_profession.id]

    needed = min(7, len(other_professions))
    wheel = random.sample(other_professions, needed) if needed else []

    def serialize(profession: Profession) -> ProfessionResponse:
        return ProfessionResponse(
            id=profession.id,
            name=profession.name,
            description=profession.description,
            tags=[TagResponse(id=tag.id, name=tag.name) for tag in profession.tags],
        )

    return ProfessionMatchResponse(
        correct_profession=serialize(correct_profession),
        wheel_professions=[serialize(item) for item in wheel],
    )

