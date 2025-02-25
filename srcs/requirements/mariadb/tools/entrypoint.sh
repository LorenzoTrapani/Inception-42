#!/bin/bash

echo "Inizializzo MariaDB..."

# Assicurati che la directory del socket esista
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chmod -R 755 /var/lib/mysql

# Inizializza il database se non è già stato inizializzato
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Database non trovato, inizializzazione in corso..."
    mariadb-install-db --user=mysql --ldata=/var/lib/mysql
fi

# Esegui il comando SQL per creare il database e l'utente
echo "Configurazione iniziale del database..."

# Avvia MySQL in background
mysqld --skip-networking &
MYSQL_PID=$!

# Attendi che MySQL sia pronto
until mysqladmin ping --silent; do
    echo "Aspettando che MySQL sia pronto..."
    sleep 1
done

# CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'password';
# GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%' WITH GRANT OPTION;
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
EOF

# Termina MySQL
kill "$MYSQL_PID"
wait "$MYSQL_PID"

echo "Database e utente creati con successo!"

# Avvia MariaDB normalmente
exec mysqld

