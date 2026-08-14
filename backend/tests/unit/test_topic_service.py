from unittest.mock import MagicMock

from app.domain.schemas import (
    AnswerResponse,
    CardResponse,
    FAQResponse,
    TagResponse,
    TopicResponse,
)
from app.services.topic_service import get_all_faqs, get_all_topics, get_cards_by_topics


def create_mock_tag(id, name):
    mock_tag = MagicMock()
    mock_tag.id = id
    mock_tag.name = name
    return mock_tag

def create_mock_faq(id, title, description):
    mock_faq = MagicMock()
    mock_faq.id = id
    mock_faq.title = title
    mock_faq.description = description
    return mock_faq

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

def create_mock_topic(id, name, tags=None, cards=None):
    topic = MagicMock()
    topic.id = id
    topic.name = name

    topic.tags = tags or []

    topic.cards = cards or []

    return topic

def test_get_all_topics_success():
    mock_db = MagicMock()

    mock_tags = [create_mock_tag(1, "tag1")]
    mock_cards = [
        create_mock_card(1, "topic1",   "title1", "desc1", None),
        create_mock_card(2, "topic2", "title2", "desc2", None),
        create_mock_card(3, "topic3", "title3", "desc3", None),
    ]
    mock_topics = [
        create_mock_topic(1, "topic1", mock_tags, mock_cards[:2]),
        create_mock_topic(2, "topic2", mock_tags, mock_cards)
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

    mock_tags = [create_mock_tag(1, "tag1")]
    mock_topics = [
        create_mock_topic(1, "topic1", mock_tags, None),
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 1
    assert result[0].cards_count == 0

def test_get_all_topics_without_tags():
    mock_db = MagicMock()

    mock_cards = [
        create_mock_card(1, "topic1", "title1", "desc1", None),
        create_mock_card(2, "topic2", "title2", "desc2", None),
        create_mock_card(3, "topic3", "title3", "desc3", None),
        create_mock_card(4, "topic4", "title4", "desc4", None),
        create_mock_card(5, "topic5", "title5", "desc5", None),
    ]
    mock_topics = [
        create_mock_topic(1, "topic1", None, mock_cards),
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 1
    assert len(result[0].tags) == 0
    assert result[0].cards_count == 5

def test_get_all_topics_response_structure():
    mock_db = MagicMock()

    mock_tags = [create_mock_tag(1, "tag1")]
    mock_topics = [
        create_mock_topic(1, "topic1", mock_tags, None),
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

    query_mock = mock_db.query.return_value
    options_mock = query_mock.options.return_value
    filter_mock = options_mock.filter.return_value
    all_mock = filter_mock.all
    all_mock.return_value = mock_cards

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

    query_mock = mock_db.query.return_value
    options_mock = query_mock.options.return_value
    filter_mock = options_mock.filter.return_value
    all_mock = filter_mock.all
    all_mock.return_value = []

    topic_ids = [10]
    result = get_cards_by_topics(mock_db, topic_ids)

    assert result == []

def test_get_cards_by_topics_without_answers():
    mock_db = MagicMock()

    mock_card = create_mock_card(1, 1, "card1", "desc1", [])

    query_mock = mock_db.query.return_value
    options_mock = query_mock.options.return_value
    filter_mock = options_mock.filter.return_value
    all_mock = filter_mock.all
    all_mock.return_value = [mock_card]

    result = get_cards_by_topics(mock_db, [1])

    assert len(result) == 1
    assert result[0].answers == []

def test_get_cards_by_topics_response_structure():
    mock_db = MagicMock()

    answers = [create_mock_answer(1, "ans1", True)]
    mock_card = create_mock_card(1, 1, "card1", "desc1", answers)

    query_mock = mock_db.query.return_value
    options_mock = query_mock.options.return_value
    filter_mock = options_mock.filter.return_value
    all_mock = filter_mock.all
    all_mock.return_value = [mock_card]

    result = get_cards_by_topics(mock_db, [1])

    assert isinstance(result[0], CardResponse)
    assert isinstance(result[0].answers[0], AnswerResponse)

def test_get_all_faqs_empty():
    mock_db = MagicMock()
    mock_db.query.return_value.all.return_value = []

    result = get_all_faqs(mock_db)

    assert result == []

def test_get_all_faqs_success():
    mock_db = MagicMock()

    mock_faqs = [
        create_mock_faq(1, "ask1", "ans1"),
        create_mock_faq(2, "ask2", "ans2"),
        create_mock_faq(3, "ask3", "ans3"),
    ]

    mock_db.query.return_value.all.return_value = mock_faqs

    result = get_all_faqs(mock_db)

    assert len(result) == 3
    assert result[0].title == "ask1"
    assert result[0].description == "ans1"

def test_get_all_faqs_response_structure():
    mock_db = MagicMock()
    mock_faq = create_mock_faq(1, "ask1", "ans1")
    mock_db.query.return_value.all.return_value = [mock_faq]

    result = get_all_faqs(mock_db)

    assert isinstance(result[0], FAQResponse)
