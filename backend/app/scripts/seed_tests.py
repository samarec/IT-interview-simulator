import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from sqlalchemy import text

from app.db.session import SessionLocal
from app.domain.models import Card, Test, TestCard, Topic


TOPIC_CODES = {
    "HTML": "html",
    "GO": "go",
    "Docker": "docker",
    "Сети": "seti",
    "JavaScript": "javascript",
    "Python": "python",
    "Linux": "linux",
    "Тестирование ПО": "qa",
    "Администрирование серверов": "admin",
    "PHP": "php",
    "Java": "java",
    "C++": "cpp",
    "HTTP-статусы": "http",
    "Основы Git": "git",
    "Базовый SQL": "sql",
}

TEST_CODES = {
    "Frontend Developer": "frontend-developer",
    "Backend Developer": "backend-developer",
    "DevOps Engineer": "devops-engineer",
}

PROFESSION_TOPICS = {
    "frontend-developer": ["HTML", "JavaScript"],
    "backend-developer": ["GO", "Python", "PHP"],
    "devops-engineer": ["Docker", "Сети", "Linux"],
}

QUESTIONS_PER_TEST = 10


def ensure_code_columns(db) -> None:
    db.execute(text("ALTER TABLE z1.topics ADD COLUMN IF NOT EXISTS code VARCHAR(100)"))
    db.execute(text("ALTER TABLE z1.tests ADD COLUMN IF NOT EXISTS code VARCHAR(100)"))
    db.commit()


def fill_topic_codes(db) -> None:
    topics = db.query(Topic).all()
    used = {topic.code for topic in topics if topic.code}
    for topic in topics:
        if topic.code:
            continue
        code = TOPIC_CODES.get(topic.name)
        if not code:
            code = topic.name.lower().replace(" ", "-").replace("+", "p")
        while code in used:
            code = f"{code}-{topic.id}"
        topic.code = code
        used.add(code)
        print(f"topic {topic.id} {topic.name!r} → {code}")
    db.commit()


def fill_existing_test_codes(db) -> None:
    tests = db.query(Test).all()
    used = {test.code for test in tests if test.code}
    for test in tests:
        if test.code:
            continue
        code = TEST_CODES.get(test.name)
        if not code:
            code = test.name.lower().replace(" ", "-")
        while code in used:
            code = f"{code}-{test.id}"
        test.code = code
        used.add(code)
        print(f"test {test.id} {test.name!r} → {code}")
    db.commit()


def attach_cards(db, test: Test, cards: list[Card]) -> None:
    db.query(TestCard).filter(TestCard.test_id == test.id).delete()
    for index, card in enumerate(cards[:QUESTIONS_PER_TEST]):
        db.add(TestCard(test_id=test.id, card_id=card.id, order_index=index))


def cards_for_topic_names(db, topic_names: list[str]) -> list[Card]:
    topics = db.query(Topic).filter(Topic.name.in_(topic_names)).all()
    topic_ids = [topic.id for topic in topics]
    if not topic_ids:
        return []
    return (
        db.query(Card)
        .filter(Card.topic_id.in_(topic_ids))
        .order_by(Card.id)
        .limit(QUESTIONS_PER_TEST)
        .all()
    )


def sync_tests_sequence(db) -> None:
    db.execute(text("SELECT setval('z1.tests_id_seq', COALESCE((SELECT MAX(id) FROM z1.tests), 1), true)"))
    db.commit()


def ensure_topic_tests(db) -> None:
    topics = db.query(Topic).all()
    existing = {test.code: test for test in db.query(Test).all() if test.code}

    for topic in topics:
        if not topic.code:
            continue
        test = existing.get(topic.code)
        if test is None:
            test = Test(
                name=topic.name,
                code=topic.code,
                description=f"Тест по теме «{topic.name}». Проверьте знания на ключевых вопросах.",
                duration_minutes=5,
            )
            db.add(test)
            db.flush()
            existing[topic.code] = test
            print(f"created test {test.code}")

        cards = (
            db.query(Card)
            .filter(Card.topic_id == topic.id)
            .order_by(Card.id)
            .limit(QUESTIONS_PER_TEST)
            .all()
        )
        attach_cards(db, test, cards)
        print(f"filled {test.code}: {len(cards)} cards")


def fill_profession_tests(db) -> None:
    for code, topic_names in PROFESSION_TOPICS.items():
        test = db.query(Test).filter(Test.code == code).first()
        if not test:
            continue
        cards = cards_for_topic_names(db, topic_names)
        attach_cards(db, test, cards)
        print(f"filled profession {code}: {len(cards)} cards")


def add_unique_indexes(db) -> None:
    db.execute(text("CREATE UNIQUE INDEX IF NOT EXISTS ix_topics_code ON z1.topics (code)"))
    db.execute(text("CREATE UNIQUE INDEX IF NOT EXISTS ix_tests_code ON z1.tests (code)"))
    db.commit()


def seed_tests() -> None:
    db = SessionLocal()
    try:
        ensure_code_columns(db)
        fill_topic_codes(db)
        fill_existing_test_codes(db)
        sync_tests_sequence(db)
        ensure_topic_tests(db)
        fill_profession_tests(db)
        add_unique_indexes(db)
        db.commit()
        print("Тесты и символьные коды готовы.")
    except Exception as error:
        db.rollback()
        raise error
    finally:
        db.close()


if __name__ == "__main__":
    seed_tests()
