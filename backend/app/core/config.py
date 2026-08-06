from pathlib import Path

from pydantic_settings import BaseSettings, SettingsConfigDict

class Config(BaseSettings):
    DB_HOST: str
    DB_USER: str
    DB_PASS: str
    DB_NAME: str
    DB_SCHEMA: str

    model_config = SettingsConfigDict(env_file=Path(__file__).resolve().parents[3]/'.env')

settings = Config()
