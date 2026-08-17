import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from app.db.session import SessionLocal
from app.domain.models import Profession, Tag, profession_tags


PROFESSION_TAGS = {
    "Frontend-разработчик": ["HTML", "JavaScript"],
    "Backend-разработчик": ["Go", "Python", "PHP", "Java", "C++"],
    "DevOps-инженер": ["Docker", "Linux", "Git"],
    "Fullstack-разработчик": ["HTML", "JavaScript", "Python", "PHP"],
    "Сетевой инженер": ["Сети", "Linux"],
    "QA-инженер": ["QA", "Git"],
    "Data Engineer": ["Python", "Linux"],
    "Системный администратор": ["Linux", "Администрирование", "Docker"],
}


def seed_profession_tags() -> None:
    db = SessionLocal()

    try:
        tags = {tag.name: tag for tag in db.query(Tag).all()}
        professions = db.query(Profession).order_by(Profession.id).all()

        for profession in professions:
            tag_names = PROFESSION_TAGS.get(profession.name)
            if not tag_names:
                print(f"skip profession {profession.id} {profession.name!r}: no mapping")
                continue

            missing = [name for name in tag_names if name not in tags]
            if missing:
                print(f"skip profession {profession.id} {profession.name!r}: missing tags {missing}")
                continue

            db.execute(profession_tags.delete().where(profession_tags.c.profession_id == profession.id))
            db.execute(
                profession_tags.insert(),
                [{"profession_id": profession.id, "tag_id": tags[name].id} for name in tag_names],
            )
            print(f"{profession.id}\t{profession.name}\t→ {', '.join(tag_names)}")

        db.commit()
        print("Теги профессий обновлены.")
    except Exception as error:
        db.rollback()
        raise error
    finally:
        db.close()


if __name__ == "__main__":
    seed_profession_tags()
