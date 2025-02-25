FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server curl

COPY mariadb-server.cnf /etc/mysql/mariadb.conf.d/
COPY /tools/entrypoint.sh /usr/local/bin/

RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql && \
    chmod -R 755 /run/mysqld /var/lib/mysql

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld"]