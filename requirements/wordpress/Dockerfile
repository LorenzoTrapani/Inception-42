FROM debian:latest

RUN apt-get update -y && apt-get upgrade -y && apt install -y php-fpm \
    php-mysqli\
    curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["php-fpm8.2", "-F"]