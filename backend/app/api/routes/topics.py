import math
from typing import List, Optional

from app.api.routes.deps import get_db, get_current_user, get_optional_current_user
from app.domain.models import Topic, User, CardType
from app.domain.schemas import (
    AnswerResponse,
    CardResponse,
    CountersResponse,
    FAQResponse,
    MetaInfo,
    NextQuestionRequest,
    PaginatedResponse,
    SessionQuestionResponse,
    StartTrainerRequest,
    TagResponse,
    TopicResponse,
)
from app.services.topic_service import (
    build_topic_response,
    complete_topic_session,
    get_all_faqs,
    get_all_topics,
    get_cards_by_topics,
    get_counters,
    get_paginated_topics,
    get_passed_counts_map,
    get_session_question,
)
from fastapi import APIRouter, Depends, HTTPException, Query, status
from sqlalchemy.orm import Session, selectinload

router = APIRouter(prefix="/topics", tags=["topics"])


@router.get("", response_model=List[TopicResponse])
def read_topics(
    db: Session = Depends(get_db),
    current_user: Optional[User] = Depends(get_optional_current_user)
):
    """Получить список всех тем. Отдает прогресс, если пользователь авторизован."""
    user_id = current_user.id if current_user else None
    return get_all_topics(db, user_id=user_id)


@router.get("/faq", response_model=List[FAQResponse], tags=["faq"])
def read_faqs(db: Session = Depends(get_db)):
    return get_all_faqs(db)


@router.get("/counters", response_model=CountersResponse)
def read_counters(db: Session = Depends(get_db)):
    """
    Получить агрегированные счетчики для шапки страницы 'Тесты'.
    Возвращает общее количество:
      - questions
      - topics
      - tests
      - users
    Доступен без авторизации (public endpoint), т.к. это публичная статистика.
    """
    counters = get_counters(db)
    return CountersResponse(**counters)


@router.get("/paginated", response_model=PaginatedResponse[TopicResponse])
def read_topics_paginated(
    page: int = Query(1, ge=1, description="Номер текущей страницы"),
    size: int = Query(10, ge=1, le=100, description="Количество элементов на странице"),
    db: Session = Depends(get_db),
    current_user: Optional[User] = Depends(get_optional_current_user)
):
    """Получить список тем с пагинацией и учетом личного прогресса пользователя."""
    user_id = current_user.id if current_user else None
    topics, total_items, counters_map = get_paginated_topics(db, page, size, user_id=user_id)
    total_pages = math.ceil(total_items / size) if size else 0

    passed_map = get_passed_counts_map(db, [topic.id for topic in topics])
    topic_responses = [
        build_topic_response(
            topic,
            counters_map.get(topic.id, 0),
            passed_map.get(topic.id, 0),
        )
        for topic in topics
    ]

    return PaginatedResponse(
        items=topic_responses,
        total_items=total_items,
        page=page,
        size=size,
        total_pages=total_pages
    )


@router.get("/{topic_id}", response_model=TopicResponse)
def read_topic_by_id(
    topic_id: int,
    db: Session = Depends(get_db),
    current_user: Optional[User] = Depends(get_optional_current_user)
):
    topic = db.query(Topic).options(selectinload(Topic.tags), selectinload(Topic.cards)).filter(Topic.id == topic_id).first()
    if not topic:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Тема с ID {topic_id} не найдена.")

    user_id = current_user.id if current_user else None
    # Получаем счетчик только для этой темы
    completed_count = 0
    if user_id:
        from app.domain.models import UserTopicCounter
        counter = db.query(UserTopicCounter).filter_by(user_id=user_id, topic_id=topic_id).first()
        if counter:
            completed_count = counter.completed_count

    passed_count = get_passed_counts_map(db, [topic_id]).get(topic_id, 0)
    return build_topic_response(topic, completed_count, passed_count)


@router.post("/cards", response_model=List[CardResponse])
def read_cards_for_topics(payload: StartTrainerRequest, db: Session = Depends(get_db)):
    if not payload.topic_ids:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Необходимо выбрать хотя бы одну тему для старта.")
    return get_cards_by_topics(db, payload.topic_ids)


@router.post("/session/question", response_model=SessionQuestionResponse)
def read_session_question(payload: NextQuestionRequest, db: Session = Depends(get_db)):
    if not payload.topic_ids:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Необходимо выбрать хотя бы одну тему для старта.")

    card, total_questions = get_session_question(db, payload.topic_ids, payload.current_index)

    if not card:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Вопрос с таким индексом не найден.")

    card_name = ""
    if card.card_type_id:
        card_name = getattr(db.query(CardType).get(card.card_type_id), "name", "")

    card_resp = CardResponse(
        id=card.id,
        topic_id=card.topic_id,
        title=card.title,
        description=card.description,
        answers=[AnswerResponse(id=a.id, title=a.title, is_correct=a.is_correct) for a in card.answers],
        card_type=card_name
    )
    metainfo = MetaInfo(total_questions=total_questions, current_question_index=payload.current_index)

    return SessionQuestionResponse(card=card_resp, metainfo=metainfo)


@router.post("/{topic_id}/complete", status_code=status.HTTP_200_OK)
def complete_topic(
    topic_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Увеличивает счетчик прохождений темы.
    Этот эндпоинт доступен ТОЛЬКО авторизованным пользователям.
    """
    try:
        complete_topic_session(db, user_id=current_user.id, topic_id=topic_id)
        return {"message": "Счетчик прохождений успешно обновлен"}
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))