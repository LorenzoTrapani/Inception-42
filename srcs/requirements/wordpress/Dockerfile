FROM debian:bullseye

EXPOSE 9000

RUN apt-get update -y && \
    apt-get install -y \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    gnupg \
    wget

RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list && \
    wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - && \
    apt-get update -y && \
    apt-get install -y \
    php8.2-fpm \
    php8.2-mysqli \
    mariadb-client \
    curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY /tools/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN mkdir -p /var/www/html /run/php && \
    chown -R nobody:nogroup /var/www/html /run/php && \
    chmod 755 /run/php

RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
    
CMD ["php-fpm8.2", "-F"]