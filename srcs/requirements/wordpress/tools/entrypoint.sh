#!/bin/bash

echo "Inizio configurazione di WordPress..."

cd /
# Scarica wp-cli se non esiste
if [ ! -f "/usr/local/bin/wp" ]; then
    echo "Scarico wp-cli..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

cd /var/www/html
if  ! wp core is-installed --allow-root 2>/dev/null ; then
    echo "Scarico WordPress..."
    wp core download --allow-root

    if [ ! -e wp-config.php ]; then
        echo -e "\e[92mConfiguro WordPress con valori fissi...\e[;0m"
        wp config create \
            --dbname="wordpress" \
            --dbuser="wpuser" \
            --dbpass="password" \
            --dbhost="mariadb" \
            --allow-root
    fi
    if ! wp db check --allow-root; then
		wp db create --allow-root
	fi
    echo "Installazione di WordPress..."
    wp core install \
        --url="lotrapan.42.fr" \
        --title="Inception" \
        --admin_user="lotrapan" \
        --admin_password="password" \
        --admin_email="lorenzotrapani00@gmail.com" \
        --allow-root

    echo "Creo utente aggiuntivo..."
    wp user create npc npc@gmail.com --role=editor --user_pass="passwordnpc" --allow-root
fi

echo "WordPress installato con successo!"

exec php-fpm8.2 -F



