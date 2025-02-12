#!/bin/bash

echo "Inizializzo MariaDB..."

# Assicurati che la directory del socket esista
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Inizializza il database se non è già stato inizializzato
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Database non trovato, inizializzazione in corso..."
    mariadb-install-db --user=mysql --ldata=/var/lib/mysql
fi

# Esegui il comando SQL per creare il database e l'utente
echo "Configurazione iniziale del database..."
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'wpuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

echo "Database e utente creati con successo!"

# Avvia MariaDB normalmente
exec mysqld

