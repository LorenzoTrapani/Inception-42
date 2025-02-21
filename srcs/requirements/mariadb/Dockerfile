FROM debian:latest

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server curl

COPY mariadb-server.cnf /etc/mysql/mariadb.conf.d/
COPY /tools/entrypoint.sh /usr/local/bin/

# Crea la directory per il socket (MariaDB)
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld"]