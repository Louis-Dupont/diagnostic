# Stage 1: Build dependencies with Poetry
FROM python:3.10-slim AS builder

ENV POETRY_VIRTUALENVS_CREATE=false

RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR /app

COPY pyproject.toml poetry.lock* /app/

RUN poetry install --no-dev --no-interaction --no-ansi

COPY ./src /app/src


# Stage 2: Build the final image
FROM python:3.10-slim

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 8000

CMD ["bash"]
