FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    lsb-release apt-transport-https ca-certificates wget

RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list 
 
RUN apt-get update -y && apt-get install -y \
    php8.2 php-mysqli mariadb-client curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY /tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /var/www/html/ 
RUN chown -R nobody:nogroup /var/www/html

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
    
CMD ["php-fpm8.2", "-F"]