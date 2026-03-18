FROM nginx:1.29.6

RUN addgroup nginxgroup \
    adduser --group nginxgroup

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d /etc/nginx/conf.d
COPY nginx/html /usr/share/nginx/html

RUN chown -R nginxuser:nginxgroup /var/cache/nginx /var/run /usr/share/nginx/html

USER nginxuser