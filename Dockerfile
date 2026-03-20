FROM nginx:1.29.6-alpine

ARG NGINX_UID=1000
ARG NGINX_GID=1000

ENV TZ=Europe/Samara

RUN apk add --no-cache tzdata \
    && addgroup -g "$NGINX_GID" -S nginxgroup \
    && adduser -S -D -H -u "$NGINX_UID" -G nginxgroup nginxuser \
    && rm -f /etc/nginx/conf.d/default.conf \
    && mkdir -p /var/cache/nginx /etc/nginx/ssl /usr/share/nginx/html \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && chown -R nginxuser:nginxgroup /var/cache/nginx /usr/share/nginx/html

COPY --chown=nginxuser:nginxgroup nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginxuser:nginxgroup nginx/conf.d /etc/nginx/conf.d
COPY --chown=nginxuser:nginxgroup nginx/html /usr/share/nginx/html

EXPOSE 80 443

USER nginxuser
