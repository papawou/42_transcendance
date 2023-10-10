FROM debian:buster AS builder

RUN apt-get update && apt-get install -y\
    ca-certificates\
    curl\
    gnupg

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

RUN NODE_MAJOR=20 && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list

RUN apt-get update && apt-get install -y\
    nodejs

WORKDIR /node/app

ENTRYPOINT [ "bash"]

FROM builder AS start

COPY /tools/start.sh /tmp
RUN chmod 777 /tmp/start.sh

ENTRYPOINT ["/tmp/start.sh"]