import logging
import sys
from diagnostic.env import settings

LOG_FORMAT = "%(asctime)s - %(name)s - %(levelname)s - %(message)s"


def configure_logging(log_level_override: str = None) -> None:
    if log_level_override:
        log_level = log_level_override
    elif settings.log_level:
        log_level = settings.log_level
    else:
        log_level = get_default_log_level(settings.environment)

    logging.basicConfig(
        level=log_level,
        format=LOG_FORMAT,
        handlers=[logging.StreamHandler(sys.stdout)],
    )


def get_default_log_level(environment: str) -> int:
    if environment == "PROD":
        return logging.ERROR
    elif environment == "STAGING":
        return logging.WARNING
    else:
        return logging.INFO


def get_logger(name: str) -> logging.Logger:
    return logging.getLogger(name)
