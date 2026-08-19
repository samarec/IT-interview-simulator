from datetime import datetime, timezone
from sqlalchemy import Table, Column, Integer, ForeignKey

from app.db.session import Base
from sqlalchemy import (
    Boolean,
    Column,
    DateTime,
    ForeignKey,
    Integer,
    String,
    Table,
    Text,
)
from sqlalchemy.orm import relationship


class Topic(Base):
    __tablename__ = "topics"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    code = Column(String(100), nullable=True, unique=True, index=True)

    tags = relationship(
        "Tag",
        secondary="z1.topic_tags",
        primaryjoin="Topic.id == z1.topic_tags.c.topic_id",
        secondaryjoin="Tag.id == z1.topic_tags.c.tag_id",
        back_populates="topics",
    )
    cards = relationship("Card", back_populates="topic", cascade="all, delete-orphan")
    professions = relationship(
        "Profession",
        secondary="z1.topic_professions",
        primaryjoin="Topic.id == z1.topic_professions.c.topic_id",
        secondaryjoin="Profession.id == z1.topic_professions.c.profession_id",
        back_populates="topics",
    )
    user_counters = relationship("UserTopicCounter", back_populates="topic", cascade="all, delete-orphan")


class Tag(Base):
    __tablename__ = "tags"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)

    topics = relationship(
        "Topic",
        secondary="z1.topic_tags",
        primaryjoin="Tag.id == z1.topic_tags.c.tag_id",
        secondaryjoin="Topic.id == z1.topic_tags.c.topic_id",
        back_populates="tags",
    )
    professions = relationship(
        "Profession",
        secondary="z1.profession_tags",
        primaryjoin="Tag.id == z1.profession_tags.c.tag_id",
        secondaryjoin="Profession.id == z1.profession_tags.c.profession_id",
        back_populates="tags",
    )
    users = relationship(
        "User",
        secondary="z1.user_tags",
        primaryjoin="Tag.id == z1.user_tags.c.tag_id",
        secondaryjoin="User.id == z1.user_tags.c.user_id",
        back_populates="tags",
    )


class Card(Base):
    __tablename__ = "cards"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    topic_id = Column(Integer, ForeignKey("z1.topics.id"), nullable=False)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=True)
    card_type_id = Column(Integer, ForeignKey("z1.card_types.id"), nullable=False)

    topic = relationship("Topic", back_populates="cards")
    answers = relationship("Answer", back_populates="card", cascade="all, delete-orphan")
    tests = relationship(
        "Test",
        secondary="z1.test_cards",
        primaryjoin="Card.id == z1.test_cards.c.card_id",
        secondaryjoin="Test.id == z1.test_cards.c.test_id",
        back_populates="cards",
        viewonly=True,
    )

class CardType(Base):
    __tablename__ = "card_types"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, unique=True)

class Answer(Base):
    __tablename__ = "answers"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    card_id = Column(Integer, ForeignKey("z1.cards.id"), nullable=False)
    title = Column(String, nullable=False)
    is_correct = Column(Boolean, nullable=False, default=False)

    card = relationship("Card", back_populates="answers")


class FAQ(Base):
    __tablename__ = "faq"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=False)


class Difficulty(Base):
    __tablename__ = "difficulties"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False, unique=True)


class Role(Base):
    __tablename__ = "roles"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), nullable=False, unique=True)
    description = Column(Text, nullable=True)

    users = relationship("User", back_populates="role")


class User(Base):
    __tablename__ = "users"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(100), nullable=False, unique=True)
    email = Column(String(255), nullable=False, unique=True)
    password_hash = Column(String(255), nullable=False)
    role_id = Column(Integer, ForeignKey("z1.roles.id"), nullable=True)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    role = relationship("Role", back_populates="users")
    topic_counters = relationship("UserTopicCounter", back_populates="user", cascade="all, delete-orphan")
    test_results = relationship("UserTestResult", back_populates="user", cascade="all, delete-orphan")

    tags = relationship(
        "Tag",
        secondary="z1.user_tags",
        primaryjoin="User.id == z1.user_tags.c.user_id",
        secondaryjoin="Tag.id == z1.user_tags.c.tag_id",
        back_populates="users",
    )


class Profession(Base):
    __tablename__ = "professions"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False, unique=True)
    description = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    tags = relationship(
        "Tag",
        secondary="z1.profession_tags",
        primaryjoin="Profession.id == z1.profession_tags.c.profession_id",
        secondaryjoin="Tag.id == z1.profession_tags.c.tag_id",
        back_populates="professions",
    )
    topics = relationship(
        "Topic",
        secondary="z1.topic_professions",
        primaryjoin="Profession.id == z1.topic_professions.c.profession_id",
        secondaryjoin="Topic.id == z1.topic_professions.c.topic_id",
        back_populates="professions",
    )
    tests = relationship("Test", back_populates="profession")


class UserTopicCounter(Base):
    __tablename__ = "user_topic_counters"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("z1.users.id"), nullable=False)
    topic_id = Column(Integer, ForeignKey("z1.topics.id"), nullable=False)
    completed_count = Column(Integer, default=0, nullable=False)

    user = relationship("User", back_populates="topic_counters")
    topic = relationship("Topic", back_populates="user_counters")


class Test(Base):
    __tablename__ = "tests"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    description = Column(Text, nullable=True)
    duration_minutes = Column(Integer, nullable=True)
    profession_id = Column(Integer, ForeignKey("z1.professions.id"), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    profession = relationship("Profession", back_populates="tests")
    test_cards = relationship("TestCard", back_populates="test", cascade="all, delete-orphan")
    cards = relationship(
        "Card",
        secondary="z1.test_cards",
        primaryjoin="Test.id == z1.test_cards.c.test_id",
        secondaryjoin="Card.id == z1.test_cards.c.card_id",
        back_populates="tests",
        viewonly=True,
    )
    user_results = relationship("UserTestResult", back_populates="test", cascade="all, delete-orphan")


class TestCard(Base):
    __tablename__ = "test_cards"
    __table_args__ = {"schema": "z1"}

    test_id = Column(Integer, ForeignKey("z1.tests.id"), primary_key=True)
    card_id = Column(Integer, ForeignKey("z1.cards.id"), primary_key=True)
    order_index = Column(Integer, nullable=True)

    test = relationship("Test", back_populates="test_cards")
    card = relationship("Card")


class UserTestResult(Base):
    """
    Результат прохождения теста пользователем.
    """
    __tablename__ = "user_test_results"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("z1.users.id"), nullable=False)
    test_id = Column(Integer, ForeignKey("z1.tests.id"), nullable=False)
    score = Column(Integer, nullable=True)
    max_score = Column(Integer, nullable=True)
    passed = Column(Boolean, default=False)
    completed_at = Column(DateTime, default=datetime.utcnow)

    user = relationship("User", back_populates="test_results")
    test = relationship("Test", back_populates="user_results")


class Test(Base):
    __tablename__ = "tests"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    code = Column(String(100), nullable=True, unique=True, index=True)
    description = Column(Text, nullable=True)
    duration_minutes = Column(Integer, default=5)
    profession_id = Column(Integer, ForeignKey("z1.professions.id"), nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    profession = relationship("Profession")
    card_links = relationship(
        "TestCard",
        back_populates="test",
        cascade="all, delete-orphan",
        order_by="TestCard.order_index",
    )
    results = relationship("UserTestResult", back_populates="test", cascade="all, delete-orphan")


class TestCard(Base):
    __tablename__ = "test_cards"
    __table_args__ = {"schema": "z1"}

    test_id = Column(Integer, ForeignKey("z1.tests.id"), primary_key=True)
    card_id = Column(Integer, ForeignKey("z1.cards.id"), primary_key=True)
    order_index = Column(Integer, default=0)

    test = relationship("Test", back_populates="card_links")
    card = relationship("Card")


class UserTestResult(Base):
    __tablename__ = "user_test_results"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("z1.users.id"), nullable=False)
    test_id = Column(Integer, ForeignKey("z1.tests.id"), nullable=False)
    score = Column(Integer, nullable=True)
    max_score = Column(Integer, nullable=True)
    passed = Column(Boolean, default=False)
    completed_at = Column(DateTime(timezone=True), default=lambda: datetime.now(timezone.utc))

    user = relationship("User", back_populates="test_results")
    test = relationship("Test", back_populates="results")


class UserTopicCounter(Base):
    __tablename__ = "user_topic_counters"
    __table_args__ = {"schema": "z1"}

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("z1.users.id"), nullable=False)
    topic_id = Column(Integer, ForeignKey("z1.topics.id"), nullable=False)
    completed_count = Column(Integer, default=0, nullable=False)

    user = relationship("User", back_populates="topic_counters")
    topic = relationship("Topic", back_populates="user_counters")


user_tags = Table(
    "user_tags",
    Base.metadata,
    Column("user_id", Integer, ForeignKey("z1.users.id"), primary_key=True),
    Column("tag_id", Integer, ForeignKey("z1.tags.id"), primary_key=True),
    schema="z1",
)

topic_tags = Table(
    "topic_tags",
    Base.metadata,
    Column("topic_id", Integer, ForeignKey("z1.topics.id"), primary_key=True),
    Column("tag_id", Integer, ForeignKey("z1.tags.id"), primary_key=True),
    schema="z1",
)

profession_tags = Table(
    "profession_tags",
    Base.metadata,
    Column("profession_id", Integer, ForeignKey("z1.professions.id"), primary_key=True),
    Column("tag_id", Integer, ForeignKey("z1.tags.id"), primary_key=True),
    Column("weight", Integer, default=1),
    schema="z1",
)

topic_professions = Table(
    "topic_professions",
    Base.metadata,
    Column("topic_id", Integer, ForeignKey("z1.topics.id"), primary_key=True),
    Column("profession_id", Integer, ForeignKey("z1.professions.id"), primary_key=True),
    schema="z1",
)
