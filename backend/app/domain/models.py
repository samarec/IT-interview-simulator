from datetime import datetime, timezone

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

topic_tags = Table(
    "topic_tags",
    Base.metadata,
    Column("topic_id", Integer, ForeignKey("topics.id"), primary_key=True),
    Column("tag_id", Integer, ForeignKey("tags.id"), primary_key=True),
)

profession_tags = Table(
    "profession_tags",
    Base.metadata,
    Column("profession_id", Integer, ForeignKey("professions.id"), primary_key=True),
    Column("tag_id", Integer, ForeignKey("tags.id"), primary_key=True),
    Column("weight", Integer, default=1),
    schema="z1",
)

topic_professions = Table(
    "topic_professions",
    Base.metadata,
    Column("topic_id", Integer, ForeignKey("topics.id"), primary_key=True),
    Column("profession_id", Integer, ForeignKey("professions.id"), primary_key=True),
    schema="z1",
)

class Topic(Base):
    __tablename__ = "topics"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)

    tags = relationship("Tag", secondary=topic_tags, back_populates="topics")
    cards = relationship("Card", back_populates="topic", cascade="all, delete-orphan")


class Tag(Base):
    __tablename__ = "tags"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)

    topics = relationship("Topic", secondary=topic_tags, back_populates="tags")


class Card(Base):
    __tablename__ = "cards"

    id = Column(Integer, primary_key=True, index=True)
    topic_id = Column(Integer, ForeignKey("topics.id"), nullable=False)
    title = Column(String, nullable=False)  # Текст вопроса
    description = Column(Text, nullable=True)  # Развёрнутый кейс

    topic = relationship("Topic", back_populates="cards")
    answers = relationship("Answer", back_populates="card", cascade="all, delete-orphan")


class Answer(Base):
    __tablename__ = "answers"

    id = Column(Integer, primary_key=True, index=True)
    card_id = Column(Integer, ForeignKey("cards.id"), nullable=False)
    title = Column(String, nullable=False)
    is_correct = Column(Boolean, nullable=False, default=False)

    card = relationship("Card", back_populates="answers")


class FAQ(Base):
    __tablename__ = "faq"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(Text, nullable=False)

class Role(Base):
    __tablename__ = "roles"
    __table_args__ = {"schema": "z1", "extend_existing": True}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(50), nullable=False, unique=True)
    description = Column(Text, nullable=False)

    users = relationship("User", back_populates="role")

class User(Base):
    __tablename__ = "users"
    __table_args__ = {"schema": "z1", "extend_existing": True}

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String(100), nullable=False, unique=True)
    email = Column(String(255), nullable=False, unique=True)
    password_hash = Column(String(255), nullable=False)
    role_id = Column(Integer, ForeignKey("z1.roles.id"), nullable=True)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=lambda: datetime.now(timezone.utc))

    role = relationship("Role", back_populates="users")

class Profession(Base):
    __tablename__ = "professions"
    __table_args__ = {"schema": "z1", "extend_existing": True}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False, unique=True)
    description = Column(Text, nullable=True)
    created_at = Column(DateTime, default=datetime.utcnow)

    tags = relationship("Tag", secondary=profession_tags, back_populates="professions")
    topics = relationship("Topic", secondary=topic_professions, back_populates="professions")