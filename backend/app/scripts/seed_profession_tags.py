import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from app.db.session import SessionLocal
from app.domain.models import Profession, Tag, profession_tags


PROFESSION_TAGS = {
    "Frontend-разработчик": [
        "HTML", "JavaScript", "CSS", "TypeScript", "React", "Vue",
        "Frontend", "Верстка", "Node.js",
    ],
    "Backend-разработчик": [
        "Go", "Python", "PHP", "Java", "C++", "Backend", "API", "REST",
        "SQL", "PostgreSQL", "MySQL", "Redis", "Django", "Spring",
        "Laravel", "Микросервисы",
    ],
    "DevOps-инженер": [
        "Docker", "Linux", "Git", "Kubernetes", "CI/CD", "Bash", "Nginx",
        "Terraform", "Мониторинг", "DevOps", "Контейнеризация",
    ],
    "Fullstack-разработчик": [
        "HTML", "JavaScript", "Python", "PHP", "CSS", "TypeScript",
        "React", "Frontend", "Backend", "SQL", "Node.js",
    ],
    "Сетевой инженер": ["Сети", "Linux", "TCP/IP", "HTTP", "DNS", "Безопасность"],
    "QA-инженер": ["QA", "Git", "Автотесты", "Selenium", "Postman", "HTTP"],
    "Data Engineer": ["Python", "Linux", "SQL", "PostgreSQL", "Базы данных"],
    "Системный администратор": [
        "Linux", "Администрирование", "Docker", "Bash", "Nginx",
        "Мониторинг", "Безопасность",
    ],
}


def get_or_create_tag(db, name: str, cache: dict[str, Tag]) -> Tag:
    if name in cache:
        return cache[name]

    tag = db.query(Tag).filter(Tag.name == name).first()
    if tag is None:
        tag = Tag(name=name, is_active=True)
        db.add(tag)
        db.flush()

    cache[name] = tag
    return tag


def seed_profession_tags() -> None:
    db = SessionLocal()

    try:
        tags_cache = {tag.name: tag for tag in db.query(Tag).all()}
        professions = db.query(Profession).order_by(Profession.id).all()

        for profession in professions:
            tag_names = PROFESSION_TAGS.get(profession.name)
            if not tag_names:
                print(f"skip profession {profession.id} {profession.name!r}: no mapping")
                continue

            tags = [get_or_create_tag(db, name, tags_cache) for name in tag_names]
            db.execute(profession_tags.delete().where(profession_tags.c.profession_id == profession.id))
            db.execute(
                profession_tags.insert(),
                [{"profession_id": profession.id, "tag_id": tag.id} for tag in tags],
            )
            print(f"{profession.id}\t{profession.name}\t→ {', '.join(tag.name for tag in tags)}")

        db.commit()
        print("Теги профессий обновлены.")
    except Exception as error:
        db.rollback()
        raise error
    finally:
        db.close()


if __name__ == "__main__":
    seed_profession_tags()
