ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
include $(ROOT_DIR)/.mk-lib/common.mk

DOCKER_DIR := $(ROOT_DIR)
DC_FILE := $(DOCKER_DIR)/docker-compose.yml
DC_CMD := $(DOCKER_COMPOSE) -f $(DC_FILE)
DC_CMD_EXEC := $(DC_CMD) exec

.PHONY:
	build start stop restart \
	bash ps status logs

build: ## Build all or c=<name> services
	@$(DC_CMD) build $(c)

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

add-job: ## Add a simple job
	@$(DC_CMD) exec app /var/app/bin/console leezy:pheanstalk:put default 'Hello, World!' 1024 3