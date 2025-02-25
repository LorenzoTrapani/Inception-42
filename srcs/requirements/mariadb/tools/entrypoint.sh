#!/bin/bash

echo "Inizializzo MariaDB..."

# Inizializza il database se non è già stato inizializzato
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Database non trovato, inizializzazione in corso..."
    mariadb-install-db --user=mysql --ldata=/var/lib/mysql
fi

mysqld --skip-networking &
MYSQL_PID=$!

until mysqladmin ping --silent; do
    echo "Aspettando che MySQL sia pronto..."
    sleep 1
done

mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
FLUSH PRIVILEGES;
EOF

kill "$MYSQL_PID"
wait "$MYSQL_PID"

echo "Database e utente creati con successo!"

exec mysqld

