import random
from typing import List, Tuple
from fastapi import HTTPException  # Добавлен импорт HTTPException

from app.domain.models import Profession
from app.domain.schemas import ProfessionMatchResponse, ProfessionResponse
from sqlalchemy.orm import Session


def match_profession(db: Session, tag_ids: List[int]) -> ProfessionMatchResponse:
    professions = db.query(Profession).all()

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

    if len(other_professions) >= 5:
        wheel = random.sample(other_professions, 5)
    else:
        wheel = other_professions
        random.shuffle(wheel)

    return ProfessionMatchResponse(
        correct_profession=ProfessionResponse(
            id=correct_profession.id,
            name=correct_profession.name,
            description=correct_profession.description,
        ),
        wheel_professions=[
            ProfessionResponse(id=p.id, name=p.name, description=p.description)
            for p in wheel
        ],
    )

