FROM debian:latest

# Aggiorna e installa mariadb-server
RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server curl

# Copia il file di configurazione e l'entrypoint
COPY mariadb-server.cnf /etc/mysql/mariadb.conf.d/
COPY entrypoint.sh /usr/local/bin/

# Crea la directory per il socket (MariaDB)
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# Assicurati che entrypoint.sh sia eseguibile
RUN chmod +x /usr/local/bin/entrypoint.sh

# Imposta entrypoint per eseguire lo script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Comando di default per avviare MariaDB
CMD ["mysqld"]
