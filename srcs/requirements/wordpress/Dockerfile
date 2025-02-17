FROM debian:latest

RUN apt-get update -y && apt-get upgrade -y && apt install -y php-fpm \
    php-mysqli\
    curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY /tools/entrypoint.sh /usr/local/bin/entrypoint.sh
    
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

    
CMD ["php-fpm8.2", "-F"]