FROM nginx:1.29.6

ENV TZ="Europe/Samara"

RUN addgroup -S nginxgroup \
    && adduser -S -D -H -G nginxgroup nginxuser \
    && rm -f /etc/nginx/conf.d/default.conf \
    && mkdir -p /var/cache/nginx /etc/nginx/ssl /usr/share/nginx/html \
    && chown -R nginxuser:nginxgroup /var/cache/nginx /usr/share/nginx/html

COPY --chown=nginxuser:nginxgroup nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginxuser:nginxgroup nginx/conf.d /etc/nginx/conf.d
COPY --chown=nginxuser:nginxgroup nginx/html /usr/share/nginx/html
COPY --chown=nginxuser:nginxgroup nginx/ssl /etc/nginx/ssl

RUN test -f /etc/nginx/ssl/cert.crt \
    && test -f /etc/nginx/ssl/key.pem \
    && chmod 644 /etc/nginx/ssl/cert.crt \
    && chmod 600 /etc/nginx/ssl/key.pem

EXPOSE 80 443

USER nginxuser
