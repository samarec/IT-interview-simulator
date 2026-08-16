from typing import List, Optional

from sqlalchemy.orm import Session, selectinload

from app.domain.models import Card, Test, TestCard, Topic, UserTestResult
from app.domain.schemas import (
    AnswerResponse,
    CardResponse,
    TestAnswerResult,
    TestAnswerSubmit,
    TestDetailResponse,
    TestResponse,
    TestSubmitResponse,
)


def _cards_count(test: Test) -> int:
    return len(test.card_links)


def build_test_response(test: Test) -> TestResponse:
    return TestResponse(
        id=test.id,
        name=test.name,
        code=test.code,
        description=test.description,
        duration_minutes=test.duration_minutes or 5,
        cards_count=_cards_count(test),
        profession_id=test.profession_id,
    )


def serialize_card(card: Card, reveal_correct: bool) -> CardResponse:
    return CardResponse(
        id=card.id,
        topic_id=card.topic_id,
        title=card.title,
        description=card.description,
        answers=[
            AnswerResponse(
                id=answer.id,
                title=answer.title,
                is_correct=answer.is_correct if reveal_correct else None,
            )
            for answer in card.answers
        ],
    )


def get_all_tests(db: Session) -> List[TestResponse]:
    tests = (
        db.query(Test)
        .options(selectinload(Test.card_links))
        .filter(Test.code.isnot(None))
        .order_by(Test.id)
        .all()
    )
    return [build_test_response(test) for test in tests]


def get_test_by_code(db: Session, code: str) -> Optional[Test]:
    return (
        db.query(Test)
        .options(
            selectinload(Test.card_links).selectinload(TestCard.card).selectinload(Card.answers)
        )
        .filter(Test.code == code)
        .first()
    )


def get_test_detail(test: Test, reveal_correct: bool) -> TestDetailResponse:
    cards = [
        serialize_card(link.card, reveal_correct)
        for link in sorted(test.card_links, key=lambda item: item.order_index)
        if link.card
    ]
    base = build_test_response(test)
    return TestDetailResponse(**base.model_dump(), cards=cards)


def submit_test(
    db: Session,
    test: Test,
    answers: List[TestAnswerSubmit],
    user_id: Optional[int] = None,
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

    if user_id:
        db.add(
            UserTestResult(
                user_id=user_id,
                test_id=test.id,
                score=correct_count,
                max_score=total,
                passed=passed,
            )
        )
        topic_ids = {link.card.topic_id for link in test.card_links if link.card}
        if len(topic_ids) == 1:
            from app.services.topic_service import complete_topic_session

            complete_topic_session(db, user_id, next(iter(topic_ids)))
        else:
            db.commit()

    return TestSubmitResponse(
        test=build_test_response(test),
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
