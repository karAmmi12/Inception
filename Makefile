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


DOCKER_COMPOSE := docker compose



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ SOURCES }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

SRCS_PATH 		=	 ./srcs

DOCKER_COMPOSE_PATH = $(SRCS_PATH)/docker-compose.yml

HOST	:= kammi.42.fr 


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ HOME }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

USER_HOME = $(shell echo ~)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~{ RULES }~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #

all: init up

up:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_PATH) up -d --build 

down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_PATH) down -v --remove-orphans

re: down up

logs:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_PATH) logs -f

volumes_list:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_PATH) ps -a

clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_PATH) down -v --remove-orphans --rmi all

fclean: clean
	@sudo rm -rd $(USER_HOME)/data/mysql
	
	
	@sudo rm -rd $(USER_HOME)/data/wordpress
	@echo "$(GREEN)Volumes removed!$(RESET)"

init:
	@echo "$(YELLOW)Creating volumes (in $(USER_HOME)/data)...$(RESET)"
	@mkdir -p $(HOME)/data/mysql
	@mkdir -p $(HOME)/data/wordpress
	@sudo chown -R $(USER) $(HOME)/data
	@sudo chmod -R 777 $(HOME)/data
	@echo "$(GREEN)Volumes created!$(RESET)"

.PHONY: all up down re clean fclean

