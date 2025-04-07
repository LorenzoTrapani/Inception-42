FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl

RUN mkdir -p /etc/ssl/certs && \
    mkdir -p /etc/ssl/private && \
    mkdir -p /var/www/html

COPY nginx.conf /etc/nginx/nginx.conf
COPY /tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN rm -f /etc/nginx/conf.d/default.conf

EXPOSE 443

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]