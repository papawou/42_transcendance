NAME := transcendance
SRC := docker-compose.yml

DOCKER_COMPOSE_CMD := docker compose -f ${SRC} -p ${NAME}

all: down build up

build:
	${DOCKER_COMPOSE_CMD} build

up:
	${DOCKER_COMPOSE_CMD} up

down:
	${DOCKER_COMPOSE_CMD} down

clean:
	${DOCKER_COMPOSE_CMD} down -v

re : clean all

.PHONY : all clean fclean re