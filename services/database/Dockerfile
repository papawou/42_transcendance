FROM debian:buster AS builder

RUN apt-get update && apt-get install -y\
    wget\
    gnupg\
    lsb-release

RUN sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update 
RUN apt-get install -y postgresql-15

ARG DB_NAME
ARG DB_USERNAME
ARG DB_USERPWD

COPY /tools /tmp
WORKDIR /tmp
RUN chmod 777 /tmp/configure.sh

USER postgres
RUN ./configure.sh

ENTRYPOINT [ "bash" ]

FROM builder as starter

ENTRYPOINT [ "/usr/lib/postgresql/15/bin/postgres", "-D", "/etc/postgresql/15/main" ]