.PHONY: help build up down restart logs shell db-shell redis-shell composer cake test clean init

help: ## Display this help message
    @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## Build all containers
	docker compose build --no-cache

up: ## Start all containers
	docker compose up -d

down: ## Stop all containers
	docker compose down

restart: ## Restart all containers
	docker compose down && docker compose up -d

logs: ## Show all logs
	docker compose logs -f

logs-app: ## Show app logs
	docker compose logs -f app

logs-db: ## Show database logs
	docker compose logs -f db

shell: ## Access the app container shell
	docker compose exec app bash

db-shell: ## Access the MySQL shell
	docker compose exec db mysql -u root -proot cakephp5

redis-shell: ## Access the Redis CLI
	docker compose exec redis redis-cli

composer: ## Run composer command
	docker compose exec app composer $(CMD)

composer-install: ## Run composer install
	docker compose exec app composer install

composer-update: ## Run composer update
	docker compose exec app composer update

cake: ## Run CakePHP console command
	docker compose exec app bin/cake $(CMD)

migrate: ## Run migrations
	docker compose exec app bin/cake migrations migrate

migrate-rollback: ## Rollback last migration
	docker compose exec app bin/cake migrations rollback

bake: ## Run bake command
	docker compose exec app bin/cake bake $(CMD)

cache-clear: ## Clear CakePHP cache
	docker compose exec app bin/cake cache clear_all

test: ## Run PHPUnit tests
	docker compose exec app vendor/bin/phpunit

init: ## Initialize CakePHP 5 project
	@echo "Initializing CakePHP 5 project..."
	@mkdir -p src
	docker compose up -d db redis
	@echo "Waiting for DB..."
	@sleep 15
	docker compose up -d --build
	@echo "Waiting for app container..."
	@sleep 10
	@echo "CakePHP 5 project initialized!"
	@echo "App:        http://localhost"
	@echo "phpMyAdmin: http://localhost:8080"
	@echo "MailHog:    http://localhost:8025"

clean: ## Remove all containers, volumes, and data
	docker compose down -v --remove-orphans

status: ## Show container status
	docker compose ps

info: ## Show project URLs
	@echo "App:        http://localhost"
	@echo "phpMyAdmin: http://localhost:8080"
	@echo "MailHog:    http://localhost:8025"
	@echo "DB Host:    localhost:3306"
	@echo "Redis:      localhost:6379"