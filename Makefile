COMPOSE_FILE := ./srcs/docker-compose.yml
DOCKER_COMPOSE := docker compose -f $(COMPOSE_FILE)

GREEN := \033[0;32m
YELLOW := \033[0;33m
RED := \033[0;31m
CYAN := \033[0;36m
RESET := \033[0m

up: build
	@echo "$(GREEN)Starting containers...$(RESET)"
	$(DOCKER_COMPOSE) up -d

build:
	@echo "$(CYAN)Creating necessary directories...$(RESET)"
	@sudo mkdir -p ~/data/wordpress ~/data/mariadb
	@echo "$(GREEN)Directories created successfully!$(RESET)"

up-build: build
	@echo "$(GREEN)Building and starting containers...$(RESET)"
	$(DOCKER_COMPOSE) up --build -d

stop:
	@containers=$$(docker ps -aq); \
	if [ -z "$$containers" ]; then \
		echo "$(YELLOW)No containers to stop.$(RESET)"; \
	else \
		echo "$(RED)Stopping all containers...$(RESET)"; \
		docker stop $$containers; \
		echo "$(GREEN)All containers stopped successfully.$(RESET)"; \
	fi

remove:
	@containers=$$(docker ps -aq); \
	if [ -z "$$containers" ]; then \
		echo "$(YELLOW)No containers to remove.$(RESET)"; \
	else \
		echo "$(RED)Removing all containers...$(RESET)"; \
		docker rm $$containers; \
		echo "$(GREEN)All containers removed successfully.$(RESET)"; \
	fi

down:
	@echo "$(RED)Shutting down and removing containers, volumes, and images...$(RESET)"
	$(DOCKER_COMPOSE) down -v --rmi all

clean: down
	@echo "$(RED)Performing deep clean...$(RESET)"
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@sudo rm -rf ~/data/wordpress
	@sudo rm -rf ~/data/mariadb
	@echo "$(GREEN)Cleanup completed!$(RESET)"

fclean: stop remove clean

re: fclean up-build

.PHONY: build up up-build stop remove down clean fclean re  
