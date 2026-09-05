NAME = inception
COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_PATH = /home/nrumpfhu/data

all: prepare build up

prepare:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

build:
	docker compose -f $(COMPOSE_FILE) build

up: prepare
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

start:
	docker compose -f $(COMPOSE_FILE) start

stop:
	docker compose -f $(COMPOSE_FILE) stop

status:
	docker compose -f $(COMPOSE_FILE) ps

logs:
	docker compose -f $(COMPOSE_FILE) logs

clean: down
	docker system prune -a --force

fclean: clean
	@sudo rm -rf $(DATA_PATH)/mariadb/*
	@sudo rm -rf $(DATA_PATH)/wordpress/*
	docker volume rm mariadb_data wordpress_data 2>/dev/null || true
	docker network rm inception 2>/dev/null || true

re: fclean all

.PHONY: all prepare build up down start stop status logs clean fclean re