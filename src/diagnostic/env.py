from pydantic_settings import BaseSettings
from typing import Literal, Optional


class Settings(BaseSettings):
    environment: Literal["DEV", "STAGING", "PROD"]
    log_level: Optional[str] = None

    class Config:
        env_file = "../../.env"


settings = Settings()
