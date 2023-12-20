FROM node:18-alpine3.16

WORKDIR /app

COPY 42_transcendance_front .

RUN npm install
RUN npm run build

FROM nginx

COPY services/frontend/tools/nginx.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/dist /usr/share/nginx/html

WORKDIR /usr/share/nginx/html

CMD ["/bin/sh", "-c", "nginx -g \"daemon off;\""]