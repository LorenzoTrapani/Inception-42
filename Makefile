COMPOSE_FILE := ./srcs/docker-compose.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

.PHONY: build up stop remove

up: build
	$(DOCKER_COMPOSE) up
	
build:
	sudo mkdir -p ~/data/wordpress ~/data/mariadb


up-build: build
	$(DOCKER_COMPOSE) up --build

stop:
	@containers=$$(docker ps -aq); \
	if [ -z "$$containers" ]; then \
		echo "No containers to stop."; \
	else \
		docker stop $$containers; \
		echo "All containers stopped successfully."; \
	fi

remove:
	@containers=$$(docker ps -aq); \
	if [ -z "$$containers" ]; then \
		echo "No containers to remove."; \
	else \
		docker rm $$containers; \
		echo "All containers removed successfully."; \
	fi

reset:
	$(DOCKER_COMPOSE) down -v --rmi all

fclean: stop remove