from sqlalchemy import func, or_
from app.domain.models import (
    Card, Test, TestCard,
    Topic, UserTestResult,
    Difficulty, CardType,
    Profession, Tag,
    topic_tags, profession_tags
)
from typing import Dict, List, Optional

from sqlalchemy.orm import Session, selectinload
from app.domain.schemas import (
    AnswerResponse,
    CardResponse,
    TagResponse,
    TestAnswerResult,
    TestAnswerSubmit,
    TestDetailResponse,
    TestResponse,
    TestSubmitResponse,
)


def _cards_count(test: Test) -> int:
    return len(test.card_links)


def _test_tags(test: Test) -> List[TagResponse]:
    tags: Dict[int, Tag] = {}
    profession = test.profession
    if profession is not None:
        for tag in profession.tags:
            tags[tag.id] = tag
    for link in test.card_links:
        topic = link.card.topic if link.card is not None else None
        if topic is None:
            continue
        for tag in topic.tags:
            tags[tag.id] = tag
    return [TagResponse(id=tag.id, name=tag.name) for tag in tags.values()]


def get_test_passed_counts_map(db: Session, test_ids: Optional[List[int]] = None) -> Dict[int, int]:
    query = db.query(
        UserTestResult.test_id,
        func.count(UserTestResult.id),
    )
    if test_ids is not None:
        if not test_ids:
            return {}
        query = query.filter(UserTestResult.test_id.in_(test_ids))
    return {
        test_id: count
        for test_id, count in query.group_by(UserTestResult.test_id).all()
    }


def _test_list_options():
    return (
        selectinload(Test.card_links).selectinload(TestCard.card).selectinload(Card.topic).selectinload(Topic.tags),
        selectinload(Test.profession).selectinload(Profession.tags),
    )


def build_test_response(
    db: Session,
    test: Test,
    passed_count: Optional[int] = None,
) -> TestResponse:
    difficulty_name = None
    if test.difficulty_id is not None:
        difficulty = db.query(Difficulty).get(test.difficulty_id)
        if difficulty:
            difficulty_name = str(difficulty.name)

    if passed_count is None:
        passed_count = get_test_passed_counts_map(db, [test.id]).get(test.id, 0)

    return TestResponse(
        id=test.id,
        name=test.name,
        code=test.code,
        description=test.description,
        duration_minutes=test.duration_minutes or 5,
        cards_count=_cards_count(test),
        profession_id=test.profession_id,
        difficulty=difficulty_name,
        tags=_test_tags(test),
        passed_count=passed_count,
    )


def serialize_card(card: Card, reveal_correct: bool, card_type: str) -> CardResponse:
    return CardResponse(
        id=card.id,
        topic_id=card.topic_id,
        title=card.title,
        description=card.description,
        card_type=card_type,
        answers=[
            AnswerResponse(
                id=answer.id,
                title=answer.title,
                is_correct=answer.is_correct if reveal_correct else None,
            )
            for answer in card.answers
        ],
    )


def get_all_tests(
        db: Session,
        search: Optional[str] = None,
        sort_by: Optional[str] = None,
        tags: Optional[List[int]] = None
) -> List[TestResponse]:
    query = db.query(Test).options(*_test_list_options()).filter(Test.code.isnot(None))

    # Поиск по подстроке в названии или описании (регистронезависимый)
    if search:
        search_term = f"%{search}%"
        query = query.filter(
            or_(
                Test.name.ilike(search_term),
                Test.description.ilike(search_term)
            )
        )

    # Фильтрация по тегам
    if tags:
        # Подзапрос: ID тестов, связанных с тегами через карточки (темы)
        topic_test_ids = (
            db.query(TestCard.test_id)
            .join(Card, TestCard.card_id == Card.id)
            .join(Topic, Card.topic_id == Topic.id)
            .join(topic_tags, Topic.id == topic_tags.c.topic_id)
            .filter(topic_tags.c.tag_id.in_(tags))
        )

        # Подзапрос: ID тестов, связанных с тегами через профессию
        prof_test_ids = (
            db.query(Test.id)
            .join(Profession, Test.profession_id == Profession.id)
            .join(profession_tags, Profession.id == profession_tags.c.profession_id)
            .filter(profession_tags.c.tag_id.in_(tags))
        )

        # Оставляем тесты, которые попадают под любое из условий
        query = query.filter(
            or_(
                Test.id.in_(topic_test_ids),
                Test.id.in_(prof_test_ids)
            )
        )

    # Сортировка
    if sort_by == "popular":
        # Сортировка по популярности (по количеству записей в UserTestResult)
        query = query.outerjoin(UserTestResult, Test.id == UserTestResult.test_id)
        query = query.group_by(Test.id)
        query = query.order_by(func.count(UserTestResult.id).desc())
    elif sort_by == "newest":
        # Сортировка по новизне
        query = query.order_by(Test.created_at.desc())
    else:
        # Сортировка по умолчанию
        query = query.order_by(Test.id)

    tests = query.all()
    passed_map = get_test_passed_counts_map(db, [test.id for test in tests])
    return [
        build_test_response(db, test, passed_map.get(test.id, 0))
        for test in tests
    ]


def get_test_by_code(db: Session, code: str) -> Optional[Test]:
    return (
        db.query(Test)
        .options(
            *_test_list_options(),
            selectinload(Test.card_links).selectinload(TestCard.card).selectinload(Card.answers),
        )
        .filter(Test.code == code)
        .first()
    )


def get_test_detail(db: Session, test: Test, reveal_correct: bool) -> TestDetailResponse:
    cards = [
        serialize_card(link.card, reveal_correct, getattr(db.query(CardType).get(link.card.card_type_id), 'name', ''))
        for link in sorted(test.card_links, key=lambda item: item.order_index)
        if link.card
    ]
    base = build_test_response(db, test)
    return TestDetailResponse(**base.model_dump(), cards=cards)


def submit_test(
    db: Session,
    test: Test,
    answers: List[TestAnswerSubmit],
    user_id: Optional[int] = None,
    mode: str = "training",
) -> TestSubmitResponse:
    selected = {item.card_id: item.answer_id for item in answers}
    results: List[TestAnswerResult] = []
    correct_count = 0

    for link in sorted(test.card_links, key=lambda item: item.order_index):
        card = link.card
        correct_answer = next((answer for answer in card.answers if answer.is_correct), None)
        selected_id = selected.get(card.id)
        is_correct = bool(correct_answer and selected_id == correct_answer.id)
        if is_correct:
            correct_count += 1
        results.append(
            TestAnswerResult(
                card_id=card.id,
                selected_answer_id=selected_id,
                correct_answer_id=correct_answer.id if correct_answer else None,
                is_correct=is_correct,
            )
        )

    total = len(results)
    passed = total > 0 and correct_count * 100 >= total * 70

    db.add(
        UserTestResult(
            user_id=user_id,
            test_id=test.id,
            score=correct_count,
            max_score=total,
            passed=passed,
            mode=mode if mode in {"training", "exam"} else "training",
        )
    )

    if user_id:
        topic_ids = {link.card.topic_id for link in test.card_links if link.card}
        if len(topic_ids) == 1:
            from app.services.topic_service import complete_topic_session

            complete_topic_session(db, user_id, next(iter(topic_ids)))
        else:
            db.commit()
    else:
        db.commit()

    return TestSubmitResponse(
        test=build_test_response(db, test),
        correct_count=correct_count,
        total=total,
        passed=passed,
        results=results,
    )


def ensure_topic_test(db: Session, topic: Topic, question_limit: int = 10) -> Test:
    if topic.code:
        existing = db.query(Test).filter(Test.code == topic.code).first()
        if existing:
            return existing

    test = Test(
        name=topic.name,
        code=topic.code,
        description=topic_test_description(topic),
        duration_minutes=5,
    )
    db.add(test)
    db.flush()

    cards = (
        db.query(Card)
        .filter(Card.topic_id == topic.id)
        .order_by(Card.id)
        .limit(question_limit)
        .all()
    )
    for index, card in enumerate(cards):
        db.add(TestCard(test_id=test.id, card_id=card.id, order_index=index))
    db.flush()
    return test


def topic_test_description(topic: Topic) -> str:
    return f"Тест по теме «{topic.name}». Проверьте знания на ключевых вопросах."
