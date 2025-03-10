# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ VARIABLES }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

# COLORS
RESET			=	\033[0m
RED				=	\033[0;31m
GREEN			=	\033[0;32m
YELLOW			=	\033[0;33m
BLUE			=	\033[0;34m
CYAN			=	\033[0;36m




# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~{ COMMANDES }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #


DOCKER_COMPOSE := $(shell \
    if command -v docker compose > /dev/null 2>&1; then \
        echo "docker compose"; \
    else \
        echo "docker-compose"; \
    fi)



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ SOURCES }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

SRCS_PATH 		=	 ./srcs

DOCKER_COMPOSE_FILE = $(SRCS_PATH)/docker-compose.yml

HOST	:= kammi.42.fr 


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ VOLUMES }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

USER_HOME = $(shell echo ~)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ RULES }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

all: check_docker check_env host make_volumes up

up:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --build 

down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v --remove-orphans

re: down up

logs:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f

clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v --remove-orphans --rmi all

fclean: clean
	@sudo rm -rd $
	
	
	@sudo rm -rd $(USER_HOME)/data/wordpress


make_volumes:
	@echo "$(YELLOW)Creating volumes (in $(USER_HOME)/data)...$(RESET)"
	@mkdir -p $(HOME)/data/mysql
	@mkdir -p $(HOME)/data/wordpress
	@sudo chown -R $(USER) $(HOME)/data
	@sudo chmod -R 777 $(HOME)/data
	@echo "$(GREEN)Volumes created!$(RESET)"

host:
	@for host in $(HOST); do \
		if grep " $$host" /etc/hosts; then \
			echo "$(GREEN)Host $$host already exists in /etc/hosts, skipping...$(RESET)"; \
		else \
			echo "$(GREEN)Adding host $$host to /etc/hosts$(RESET)"; \
			echo "127.0.0.1 $$host" | sudo tee -a /etc/hosts > /dev/null; \
		fi \
	done

check_env:
	@if [ ! -f $(SRCS_PATH)/.env ]; then \
		echo "$(RED)Error: .env file not found!$(RESET)"; \
		exit 1; \
	fi

check_docker:
	@if ! docker --version > /dev/null 2>&1; then \
		echo "$(RED)Error: Docker not installed!$(RESET)"; \
		exit 1; \
	fi

	@if ! $(DOCKER_COMPOSE) --version > /dev/null 2>&1; then \
		echo "$(RED)Error: Docker Compose not installed!$(RESET)"; \
		exit 1; \
	fi

.PHONY: all up down re clean fclean

