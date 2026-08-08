import os
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent.parent.parent
DATABASE_URL = os.getenv(
    "DATABASE_URL",
    "postgresql+psycopg2://postgres:postgres@localhost:5432/it_trainer"
)