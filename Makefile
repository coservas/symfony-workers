ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include $(ROOT_DIR)/.mk-lib/common.mk

DOCKER_DIR := $(ROOT_DIR)
DC_FILE := $(DOCKER_DIR)/docker-compose.yml
DC_CMD := $(DOCKER_COMPOSE) -f $(DC_FILE)
DC_CMD_EXEC := $(DC_CMD) exec

.PHONY:
	install build start stop restart \
	add-job bash ps status logs

add-job: ## Add a simple job
	@$(DC_CMD_EXEC) app /var/app/bin/console leezy:pheanstalk:put default 'Hello, World!' 1024 5

build: ## Build all or c=<name> services
	@$(DC_CMD) build $(c)

install: ## Install application
	@make build
	@make start c=app
	@$(DC_CMD_EXEC) app /bin/bash -c "cd /var/app && composer install --no-interaction --ansi --no-suggest --prefer-dist"
	@make restart

start: ## Start all or c=<name> containers in background
	@$(DC_CMD) up -d $(c)

stop: ## Stop all or c=<name> containers
	@$(DC_CMD) stop $(c)

restart: ## Restart all or c=<name> containers
	@$(DC_CMD) stop $(c)
	@$(DC_CMD) up -d $(c)

bash: ## Exec bash on php-cli
	@$(DC_CMD_EXEC) app bash

ps: status ## Alias of status
status: ## Show status of containers
	@$(DC_CMD) ps

logs: ## Show all or c=<name> logs of containers
	@$(DC_CMD) logs -f $(c)