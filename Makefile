PACKAGE_NAME=diagnostic

.PHONY: setup
setup:
	pip install poetry
	poetry config virtualenvs.in-project true # Ensure .venv is created locally
	poetry install

.PHONY: activate
activate:
	@echo "Run this command to activate the virtual environment:"
	@echo "source .venv/bin/activate"


.PHONY: test
test:
	poetry run pytest

.PHONY: format
format:
	poetry run black src/ tests/

.PHONY: clean
clean:
	rm -rf .venv
	rm -rf __pycache__/
	rm -rf .pytest_cache/
	rm -rf .coverage
	rm -rf htmlcov


# DOCKER
.PHONY: docker-build
docker-build:
	@echo "Building Docker image..."
	docker build -t $(PACKAGE_NAME) .

.PHONY: docker-run
docker-run:
	@echo "Running the Docker container..."
	docker run -p 8000:8000 $(PACKAGE_NAME)

.PHONY: docker-clean
docker-clean:
	@echo "Removing Docker image..."
	docker rmi $(PACKAGE_NAME)

.PHONY: docker-kill-all
docker-kill-all:
	@echo "Run: `docker kill $(docker ps -q)`"

.PHONY: docker-clean-all
docker-clean-all:
	@echo "Run: `docker rm $(docker ps -a -q)`"
