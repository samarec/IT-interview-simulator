import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from sqlalchemy.orm import selectinload

from app.db.session import SessionLocal
from app.domain.models import Tag, Topic, topic_tags


# Первый тег — основной (иконка и бейдж на карточке теста).
TOPIC_TAGS = {
    "HTML": ["HTML", "CSS", "Frontend", "Верстка"],
    "GO": ["Go", "Backend", "API", "Микросервисы", "REST"],
    "Docker": ["Docker", "DevOps", "Kubernetes", "CI/CD", "Контейнеризация"],
    "Сети": ["Сети", "Git", "TCP/IP", "HTTP", "DNS", "Безопасность"],
    "JavaScript": ["JavaScript", "TypeScript", "React", "Vue", "Node.js", "Frontend"],
    "Python": ["Python", "Backend", "Django", "SQL", "PostgreSQL"],
    "Linux": ["Linux", "Bash", "DevOps", "Администрирование"],
    "Тестирование ПО": ["QA", "Автотесты", "Selenium", "Postman"],
    "Администрирование серверов": ["Администрирование", "Nginx", "Мониторинг", "Bash", "Безопасность"],
    "PHP": ["PHP", "Backend", "Laravel", "MySQL", "SQL"],
    "Java": ["Java", "Backend", "Spring", "ООП"],
    "C++": ["C++", "ООП", "Алгоритмы"],
    "Тензор": ["Saby", "Собеседование", "Стажировка"],
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


def refine_topic_tags() -> None:
    db = SessionLocal()

    try:
        tags_cache = {tag.name: tag for tag in db.query(Tag).all()}
        topics = db.query(Topic).options(selectinload(Topic.tags)).order_by(Topic.id).all()

        for topic in topics:
            tag_names = TOPIC_TAGS.get(topic.name)
            if not tag_names:
                print(f"skip topic {topic.id} {topic.name!r}: no mapping")
                continue

            tags = [get_or_create_tag(db, name, tags_cache) for name in tag_names]
            db.execute(topic_tags.delete().where(topic_tags.c.topic_id == topic.id))
            db.execute(
                topic_tags.insert(),
                [{"topic_id": topic.id, "tag_id": tag.id} for tag in tags],
            )
            print(f"{topic.id}\t{topic.name}\t→ {', '.join(tag.name for tag in tags)}")

        db.commit()
        print("Теги тестов обновлены.")
    except Exception as error:
        db.rollback()
        raise error
    finally:
        db.close()


if __name__ == "__main__":
    refine_topic_tags()
