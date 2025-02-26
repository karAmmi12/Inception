NAME = inception

all: up

up:
	@printf "Starting Docker containers...\n"
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	@printf "Stopping Docker containers...\n"
	@docker-compose -f ./srcs/docker-compose.yml down

clean: down
	@printf "Cleaning up Docker resources...\n"
	@docker system prune -af
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true

fclean: clean
	@printf "Full cleanup in progress...\n"
	@docker network prune -f
	@sudo rm -rf /home/$$USER/data/wordpress/*
	@sudo rm -rf /home/$$USER/data/mariadb/*

re: fclean all

.PHONY: all up down clean fclean re