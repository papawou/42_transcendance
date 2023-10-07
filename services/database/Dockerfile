FROM debian:buster

RUN apt-get update && apt-get install -y\
    wget

RUN sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

RUN apt-get update && apt-get install -y\
    postgresql-15

COPY /tools /tmp

WORKDIR /tmp
RUN chmod 777 /tmp/configure.sh
RUN ./configure.sh

ENTRYPOINT [ "bash" ]