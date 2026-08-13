from unittest.mock import MagicMock

from app.services.topic_service import get_all_topics

def create_mock_topic(name, tags_count, cards_count):
    topic = MagicMock()
    topic.id = 1
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
        card.id = i,
        card.topic_id = 1,
        card.title = f"Card {i}",
        card.description = f"Description {i}"
        topic.cards.append(card)

    return topic

def test_get_all_topics_success():
    mock_db = MagicMock()
    mock_topics = [
        create_mock_topic("topic1", 1, 2),
        create_mock_topic("topic2", 1, 3)
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 2
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
        create_mock_topic("topic1", 1, 0),
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 1
    assert result[0].cards_count == 0

def test_get_all_topics_without_tags():
    mock_db = MagicMock()

    mock_topics = [
        create_mock_topic("topic1", 0, 5),
    ]

    mock_db.query.return_value.options.return_value.all.return_value = mock_topics

    result = get_all_topics(mock_db)

    assert len(result) == 1
    assert len(result[0].tags) == 0
