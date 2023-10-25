NAME := transcendance
SRC := docker-compose.yml

DOCKER_COMPOSE_CMD := docker compose -f ${SRC} -p ${NAME}
TARGET_DEV := cat docker-compose.yml | sed 's/target: starter/target: builder/' | docker compose -f - -p ${NAME} up --build -d

RED =	'\033[0;31m'
CYAN =	'\033[0;36m'
NC =	'\033[0m' # No Color

all: down build up

build:
	${DOCKER_COMPOSE_CMD} build

up:
	${DOCKER_COMPOSE_CMD} up

frontend_dev:
	${TARGET_DEV} frontend
	docker attach transcendance-frontend-1

backend_dev:
	${TARGET_DEV} backend
	docker attach transcendance-backend-1

database_dev:
	${TARGET_DEV} database
	docker attach transcendance-database-1

frontend:
	 ${DOCKER_COMPOSE_CMD} up --build frontend

backend:
	 ${DOCKER_COMPOSE_CMD} up --build backend

database:
	 ${DOCKER_COMPOSE_CMD} up --build database

down:
	${DOCKER_COMPOSE_CMD} down

status:
		@echo ${CYAN}----- git status MAIN${NC} &&\
		git status
		@cd ../42_transcendance_front &&\
		echo ${CYAN}----- git status FRONT${NC} &&\
		git status
		@cd ../42_transcendance_backend &&\
		echo ${CYAN}----- git status BACKEND${NC} &&\
		git status

log:
		@echo ${CYAN}----- git log MAIN${NC} &&\
		git --no-pager log -7 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit &&\
		echo ""
		@cd ../42_transcendance_front &&\
		echo ${CYAN}----- git log FRONT${NC} &&\
		git --no-pager log -7 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit &&\
		echo ""
		@cd ../42_transcendance_backend &&\
		echo ${CYAN}----- git log BACKEND${NC} &&\
		git --no-pager log -7 --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit &&\
		echo ""

clean:
	${DOCKER_COMPOSE_CMD} down -v
	@docker system prune -a --volumes

re : clean all

.PHONY : all clean fclean re