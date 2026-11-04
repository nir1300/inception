NAME = inception
COMPOSE_FILE = ./srcs/docker-compose.yml
DATA_PATH = /home/nrumpfhu/data

all: build up

build:
	mkdir -p /home/nrumpfhu/data/mariadb/
	mkdir -p /home/nrumpfhu/data/wordpress/
	docker compose -f $(COMPOSE_FILE) build

up: 
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

stop:
	docker compose -f $(COMPOSE_FILE) stop

status:
	docker compose -f $(COMPOSE_FILE) ps

fclean: down
	@sudo rm -rf $(DATA_PATH)/mariadb/* $(DATA_PATH)/wordpress/*
	@echo "Data wiped."

re: fclean all

.PHONY: all build up down stop status fclean re
