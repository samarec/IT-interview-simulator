from unittest.mock import MagicMock

from app.domain.schemas import TopicResponse, TagResponse, CardResponse, AnswerResponse
from app.services.topic_service import get_all_topics, get_cards_by_topics

def create_mock_answer(id, title, is_correct):
    mock_answer = MagicMock()
    mock_answer.id = id
    mock_answer.title = title
    mock_answer.is_correct = is_correct
    return mock_answer

def create_mock_card(id, topic_id, title, description, answers):
    mock_card = MagicMock()
    mock_card.id = id
    mock_card.topic_id = topic_id
    mock_card.title = title
    mock_card.description = description
    mock_card.answers = answers
    return mock_card

def create_mock_topic(id, name, tags_count, cards_count):
    topic = MagicMock()
    topic.id = id
    topic.name = name

    topic.tags = []
    for i in range(tags_count):
        tag = MagicMock()
        tag.id = i
        tag.name = f"tag_{i+1}"
        topic.tags.append(tag)

    topic.cards = []
    for i in range(cards_count):
        card = MagicMock()
        card.id = i
        card.topic_id = 1
        card.title = f"Card {i}"
        card.description = f"Description {i}"
        topic.cards.append(card)

    return topic

def test_get_all_topics_success():
    mock_db = MagicMock()
    mock_topics = [
        create_mock_topic(1, "topic1", 1, 2),
        create_mock_topic(2, "topic2", 1, 3)
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 2
    assert result[0].name == "topic1"
    assert result[0].id == 1
    assert result[0].cards_count == 2
    assert result[1].cards_count == 3

def test_get_all_topics_empty():
    mock_db = MagicMock()

    mock_db.query.return_value.options.return_value.all.return_value = []

    result = get_all_topics(mock_db)

    assert result == []

def test_get_all_topics_without_cards():
    mock_db = MagicMock()

    mock_topics = [
        create_mock_topic(1, "topic1", 1, 0),
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 1
    assert result[0].cards_count == 0

def test_get_all_topics_without_tags():
    mock_db = MagicMock()

    mock_topics = [
        create_mock_topic(1, "topic1", 0, 5),
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 1
    assert len(result[0].tags) == 0

def test_get_all_topics_response_structure():
    mock_db = MagicMock()

    mock_topics = [
        create_mock_topic(1, "topic1", 1, 2),
        create_mock_topic(2, "topic2", 1, 3)
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert isinstance(result[0], TopicResponse)
    assert isinstance(result[0].tags[0], TagResponse)

def test_get_cards_by_topics_empty():
    mock_db = MagicMock()

    result = get_cards_by_topics(mock_db, [])

    assert result == []
    mock_db.assert_not_called()

def test_get_cards_by_topics_success():
    mock_db = MagicMock()

    answers1 = [
        create_mock_answer(1, "ans1.1", True),
        create_mock_answer(2, "ans1.2",False),
    ]

    answers2 = [
        create_mock_answer(3, "ans2.1",True),
    ]

    mock_cards = [
        create_mock_card(1, 1, "card1", "desc1", answers1),
        create_mock_card(2, 2, "card2", "desc2", answers2),
        create_mock_card(3, 1, "card3", "desc3", [])
    ]

    mock_db.query.return_value.options.return_value.filter.return_value.all.return_value = mock_cards

    topic_ids = [1, 2]
    result = get_cards_by_topics(mock_db, topic_ids)

    assert len(result) == 3
    assert result[0].topic_id == 1
    assert result[0].title == "card1"
    assert result[0].description == "desc1"
    assert len(result[0].answers) == 2
    assert result[0].answers[0].is_correct is True
    assert result[0].answers[1].is_correct is False

def test_get_cards_by_topics_no_result():
    mock_db = MagicMock()

    mock_db.query.return_value.options.return_value.filter.return_value.all.return_value = []
    topic_ids = [10]
    result = get_cards_by_topics(mock_db, topic_ids)

    assert result == []

def test_get_cards_by_topics_without_answers():
    mock_db = MagicMock()

    mock_card = create_mock_card(1, 1, "card1", "desc1", [])

    mock_db.query.return_value.options.return_value.filter.return_value.all.return_value = [mock_card]

    result = get_cards_by_topics(mock_db, [1])

    assert len(result) == 1
    assert result[0].answers == []

def test_get_cards_by_topics_response_structure():
    mock_db = MagicMock()

    answers = [create_mock_answer(1, "ans1", True)]
    mock_card = create_mock_card(1, 1, "card1", "desc1", answers)
    mock_db.query.return_value.options.return_value.filter.return_value.all.return_value = [mock_card]

    result = get_cards_by_topics(mock_db, [1])

    assert isinstance(result[0], CardResponse)
    assert isinstance(result[0].answers[0], AnswerResponse)