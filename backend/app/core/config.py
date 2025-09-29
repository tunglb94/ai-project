# app/core/config.py

from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    # Database settings
    SQLALCHEMY_DATABASE_URL: str

    # Google AI API Key
    GOOGLE_API_KEY: str

    # JWT Settings for security
    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 7 # 7 days

    class Config:
        env_file = ".env"

settings = Settings()