"""init_db

Revision ID: 030a32a61b6a
Revises: 
Create Date: 2026-08-05 13:38:19.432117

"""
from typing import Sequence, Union

from alembic import op

from backend.app.core.config import settings


# revision identifiers, used by Alembic.
revision: str = '030a32a61b6a'
down_revision: Union[str, Sequence[str], None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    schema = settings.DB_SCHEMA

    op.execute(f"""
        CREATE TABLE IF NOT EXISTS {schema}.tags
        (
            id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            name TEXT NOT NULL
        )
    """)

    op.execute(f"""
        CREATE TABLE IF NOT EXISTS {schema}.topics
        (
            id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            name TEXT NOT NULL
        )
    """)

    op.execute(f"""
        CREATE TABLE IF NOT EXISTS {schema}.topic_tags
        (
            topic_id BIGINT REFERENCES {schema}.topics(id) ON DELETE CASCADE,
            tag_id BIGINT REFERENCES {schema}.tags(id) ON DELETE CASCADE,
            PRIMARY KEY (topic_id, tag_id)
        )
    """)

    op.execute(f"""
        CREATE TABLE IF NOT EXISTS {schema}.cards
        (
            id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            topic_id BIGINT REFERENCES {schema}.topics(id) ON DELETE CASCADE,
            title TEXT NOT NULL,
            description TEXT
        )
    """)

    op.execute(f"""
        CREATE TABLE IF NOT EXISTS {schema}.answers
        (
            id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            card_id BIGINT REFERENCES {schema}.cards(id) ON DELETE CASCADE,
            title TEXT NOT NULL,
            is_correct BOOLEAN NOT NULL
        )
    """)

    op.execute(f"""
        CREATE TABLE IF NOT EXISTS {schema}.faq
        (
            id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
            title TEXT NOT NULL,
            description TEXT NOT NULL
        )
    """)

def downgrade() -> None:
    schema = settings.DB_SCHEMA

    op.execute(f"""
        DROP TABLE IF EXISTS {schema}.answers
    """)

    op.execute(f"""
        DROP TABLE IF EXISTS {schema}.cards
    """)

    op.execute(f"""
        DROP TABLE IF EXISTS {schema}.topic_tags
    """)

    op.execute(f"""
        DROP TABLE IF EXISTS {schema}.topics
    """)

    op.execute(f"""
        DROP TABLE IF EXISTS {schema}.tags
    """)

    op.execute(f"""
        DROP TABLE IF EXISTS {schema}.faq
    """)
