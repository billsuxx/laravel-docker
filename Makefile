PHONY: help
.DEFAULT_GOAL := help
help:
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: start
start: ## Start the vagrant box
	docker-compose up -d

.PHONY: stop
stop: ## Stop the vagrant box
	docker-compose down

.PHONY: composer
composer: ## Run composer install
	docker-compose run php composer install

.PHONY: migrate
migrate: ## Run artisan migrate
	docker-compose run php php artisan migrate

.PHONY: install-assetic
install-assetic: ## Install npm modules
	docker-compose run --rm node install

.PHONY: build-assetic
build-assetic: ## Create assetic files
	docker-compose run --rm node run dev

.PHONY: build-assetic-watch
build-assetic-watch: ## Watch assetic files change
	docker-compose run --rm node run watch

.PHONY: migrate-refresh
migrate-refresh: ## Run artisan migrate and db:seed
	docker-compose run php php artisan migrate:refresh && php artisan db:seed
