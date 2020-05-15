.ONESHELL:
SHELL = /bin/bash

default: help


## begin # help

.PHONY: list
list: ## Show commands list [shortcut: "l"]
	$(call list)

.PHONY: l
l:list

.PHONY: help
help: ## Show help message [shortcut: "h"]
	@echo -e "\e[32mNotes:\e[0m"
	@echo -e "Tip: for faster use, you can add an alias of the form  \e[33m\`mk\`\e[0m for command \e[33m\`make\`\e[0m"
	@echo -e "\e[32mCommands:\e[0m"
	$(call list)

.PHONY: h
h: help

## end # help


## begin # Environment

.PHONY: build
build: ## Build all containers with docker-compose.yml [shortcut: "b"]
	$(call dc, build)

.PHONY: b
b: build

.PHONY: start
start:  ## Start all containers with docker-compose.yml
	$(call dc, exec up -d --remove-orphans)

.PHONY: ps
ps: ## Show containers list with docker-compose.yml
	$(call dc, ps)

.PHONY: stop
stop: ## Stop all containers with docker-compose.yml
	$(call dc, stop)

.PHONY: down
down: ## Stop and delete all containers and volumes with docker-compose.yml [shortcut: "d"]
	$(call dc, down -v --remove-orphans)

.PHONY: d
d: down

## end # Environment

define list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## |[][]"}; {printf "\033[36m%-25s\033[0m %s \033[33m[\033[0m\033[32m%s\033[0m\033[33m]\033[0m\n", $$1, $$2, $$3}'
endef

define dc
	@docker-compose $1
endef

