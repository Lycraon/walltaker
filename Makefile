
BRANCH = main
REPO = https://github.com/Lycraon/walltaker.git
REPO_URL ?= $(REPO)\#$(BRANCH)

PROJECT ?= -p walltaker

ENV_FILES ?= --env-file .env.example --env-file walltaker.env
PROFILES ?=
CONFIG_FILE ?= docker-compose-app.yml
COMPOSE_OPTIONS ?= $(ENV_FILES) $(PROJECT) -f $(CONFIG_FILE) $(PROFILES) $(COMPOSE_ARGS)

#running script that installs this file lmao
install:
	./scripts/install.sh $(BRANCH)

config:
	docker compose $(ENV_FILES) -f $(REPO_URL):$(CONFIG_FILE) $(PROFILES) $(COMPOSE_ARGS) config -o $(CONFIG_FILE)

build:
	make config
	docker compose $(COMPOSE_OPTIONS) pull --ignore-buildable
	docker compose $(COMPOSE_OPTIONS) build $(BUILD_ARGS)

#--d to run in detached mode -> console will not be blocked
run:
	docker compose $(COMPOSE_OPTIONS) up -d $(RUN_ARGS)

stop:
	docker compose $(COMPOSE_OPTIONS) stop $(STOP_ARGS)

# -f to skip confirmation, -s to stop containers before removal
remove:
	docker compose $(COMPOSE_OPTIONS) rm $(REMOVE_ARGS) 

restart:
	docker compose $(COMPOSE_OPTIONS) restart $(RESTART_ARGS)

rebuild:
	-make stop || true
	-make remove REMOVE_ARGS="-s -f" || true
	make build

deploy:
	make rebuild
	make run

ls:
	docker compose ls
	docker image ls
	docker ps -a

logs:
	docker  $(PROJECT) $(CONFIG_FILE) $(PROFILES) compose logs

#Infrastructure ----------------------------------------------------------------------------------
PROFILES_INFR = 
CONFIG_FILE_INFR=docker-compose-infrastructure.yml

infra-config:
	make config PROFILES="$(PROFILES_INFR)" CONFIG_FILE="$(CONFIG_FILE_INFR)"

infra-build:
	make build PROFILES="$(PROFILES_INFR)" CONFIG_FILE="$(CONFIG_FILE_INFR)"

infra-run:
	make run PROFILES="$(PROFILES_INFR)" CONFIG_FILE="$(CONFIG_FILE_INFR)"
infra-stop:
	make stop PROFILES="$(PROFILES_INFR)" CONFIG_FILE="$(CONFIG_FILE_INFR)"
infra-remove:
	make remove PROFILES="$(PROFILES_INFR)" CONFIG_FILE="$(CONFIG_FILE_INFR)"
infra-restart:
	make restart PROFILES="$(PROFILES_INFR)" CONFIG_FILE="$(CONFIG_FILE_INFR)"
