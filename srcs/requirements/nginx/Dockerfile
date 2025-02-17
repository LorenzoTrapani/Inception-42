FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx

RUN apt-get install -y openssl && \
    mkdir -p /usr/lib/ssl && \
    mkdir -p /etc/ssl/certs && \
    mkdir -p /etc/ssl/private && \
    mkdir -p /var/www/html

COPY nginx.conf /etc/nginx/nginx.conf
COPY /tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]