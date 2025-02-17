#!/bin/bash

echo "Inizio configurazione di WordPress..."

# Scarica wp-cli se non esiste
if [ ! -f "/usr/local/bin/wp" ]; then
    echo "Scarico wp-cli..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

if  ! wp core is-installed --path=/var/www/html --allow-root 2>dev/null ; then
    echo "Scarico WordPress..."
    wp core download --path=/var/www/html --allow-root

    if [ ! -f /var/www/wp-config.php ]; then
        echo "Configuro WordPress con valori fissi..."
        wp config create \
            --path=/var/www/html \
            --dbname="wordpress" \
            --dbuser="wpuser" \
            --dbpass="password" \
            --dbhost="mariadb" \
            --allow-root
    fi
    
    echo "Installazione di WordPress..."
    wp core install \
        --path=/var/www/html \
        --url="lotrapan.42.fr" \
        --title="Inception" \
        --admin_user="lotrapan" \
        --admin_password="password" \
        --admin_email="lorenzotrapani00@gmail.com" \
        --allow-root

    echo "Creo utente aggiuntivo..."
    wp user create npc npc@gmail.com --role=editor --user_pass="passwordnpc" --path=/var/www/html --allow-root
fi

echo "WordPress installato con successo!"

php-fpm8.2 -F


