import os
import sys

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__)))))

from app.db.session import Base, SessionLocal, engine
from app.domain.models import FAQ, Answer, Card, Tag, Topic, Role, Profession, Test, TestCard


def seed_data():
    Base.metadata.create_all(bind=engine)
    db = SessionLocal()

    try:
        if db.query(Role).first() or db.query(Topic).first():
            print("База данных уже содержит данные. Пропуск заполнения.")
            return

        print("Заполнение базы данных начальными данными...")

        role_admin = Role(id=1, name="Admin")
        role_user = Role(id=2, name="User")
        db.add_all([role_admin, role_user])

        tag_web = Tag(name="Web")
        tag_networks = Tag(name="Сети")
        tag_devops = Tag(name="DevOps")
        tag_db = Tag(name="Базы данных")

        extra_tags_names = [
            "HTML", "JavaScript", "Go", "Python", "PHP", "Java", "C++",
            "Docker", "Linux", "Git", "QA", "Администрирование"
        ]
        extra_tags = [Tag(name=name) for name in extra_tags_names]

        db.add_all([tag_web, tag_networks, tag_devops, tag_db] + extra_tags)

        prof_frontend = Profession(name="Frontend-разработчик", description="Создает UI", tags=[tag_web])
        prof_backend = Profession(name="Backend-разработчик", description="Пишет API",
                                  tags=[tag_web, tag_db, tag_networks])
        prof_devops = Profession(name="DevOps-инженер", description="Настраивает CI/CD",
                                 tags=[tag_devops, tag_networks])
        db.add_all([prof_frontend, prof_backend, prof_devops])

        topic_http = Topic(name="HTTP-статусы", code="http", tags=[tag_web, tag_networks])
        topic_git = Topic(name="Основы Git", code="git", tags=[tag_devops])
        topic_sql = Topic(name="Базовый SQL", code="sql", tags=[tag_db])
        db.add_all([topic_http, topic_git, topic_sql])

        db.flush()

        card_1 = Card(
            topic_id=topic_http.id,
            title="Чем HTTP 401 отличается от 403?",
            description="401 Unauthorized — клиент не аутентифицирован. 403 Forbidden — клиент известен, но доступ запрещён.",
            answers=[
                Answer(title="401 — не аутентифицирован, 403 — доступ запрещён", is_correct=True),
                Answer(title="401 — ошибка сервера, 403 — ресурс не найден", is_correct=False),
                Answer(title="Это идентичные статусы", is_correct=False),
            ],
        )

        card_2 = Card(
            topic_id=topic_http.id,
            title="Что означает статус HTTP 500 Internal Server Error?",
            description="Указывает на то, что на стороне сервера произошла непредвиденная ошибка.",
            answers=[
                Answer(title="Сервер временно недоступен", is_correct=False),
                Answer(title="Внутренняя ошибка сервера", is_correct=True),
                Answer(title="Запрос клиента содержал ошибку", is_correct=False),
            ],
        )

        card_3 = Card(
            topic_id=topic_git.id,
            title="В чём разница между git fetch и git pull?",
            description="git fetch только скачивает изменения, git pull скачивает и сразу сливает их.",
            answers=[
                Answer(title="git fetch сливает изменения, git pull только скачивает", is_correct=False),
                Answer(title="git pull = git fetch + git merge", is_correct=True),
                Answer(title="Между ними нет никакой разницы", is_correct=False),
            ],
        )

        card_4 = Card(
            topic_id=topic_sql.id,
            title="Чем WHERE отличается от HAVING в SQL?",
            description="WHERE фильтрует строки до GROUP BY, HAVING — после группировки.",
            answers=[
                Answer(title="WHERE фильтрует до GROUP BY, HAVING — после", is_correct=True),
                Answer(title="HAVING применяется только в UPDATE", is_correct=False),
                Answer(title="Это синонимы", is_correct=False),
            ],
        )

        faq_1 = FAQ(
            title="Как работать с тренажёром?",
            description="Выбирайте интересующие темы на главной странице и нажимайте 'Запустить тренажёр'.",
        )

        test_http = Test(
            name="HTTP-статусы",
            code="http",
            description="Тест по теме «HTTP-статусы». Проверьте знания на ключевых вопросах.",
            duration_minutes=5,
        )
        db.add_all([card_1, card_2, card_3, card_4, faq_1, test_http])
        db.flush()
        db.add_all([
            TestCard(test_id=test_http.id, card_id=card_1.id, order_index=0),
            TestCard(test_id=test_http.id, card_id=card_2.id, order_index=1),
        ])
        db.commit()
        print("База данных успешно заполнена!")

    except Exception as e:
        db.rollback()
        print(f"Ошибка при заполнении БД: {e}")
    finally:
        db.close()


if __name__ == "__main__":
    seed_data()

