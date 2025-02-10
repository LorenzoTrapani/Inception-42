#!/bin/bash
# Entry point personalizzato per eseguire l'inizializzazione del database

# Aspetta che MariaDB sia pronto per accettare connessioni
# until mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" ping --silent; do
#   echo "Aspettando MariaDB..."
#   sleep 2
# done

echo "MariaDB è pronto! Eseguo l'inizializzazione..."

# Esegui il comando SQL per creare il database e l'utente
mysql -u root -p"$MYSQL_ROOT_PASSWORD" <<EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'wpuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

echo "Database e utente creati con successo!"

# Avvia MariaDB
exec "$@"
