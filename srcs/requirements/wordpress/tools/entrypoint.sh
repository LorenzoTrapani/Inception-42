#!/bin/bash

echo "Inizio configurazione di WordPress..."

cd /

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
        echo -e "\e[92mConfiguro WordPress...\e[;0m"
        wp config create \
            --dbname="${MYSQL_DATABASE}" \
            --dbuser="${MYSQL_USER}" \
            --dbpass="${MYSQL_PASSWORD}" \
            --dbhost="${MYSQL_HOSTNAME}" \
            --allow-root
    fi
    if ! wp db check --allow-root; then
		wp db create --allow-root
	fi
    echo "Installazione di WordPress..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    echo "Creo utente aggiuntivo..."
    wp user create ${WP_USER} ${WP_USER_EMAIL} --role=editor --user_pass="${WP_USER_PASSWORD}" --allow-root
fi

echo "WordPress installato con successo!"

exec php-fpm8.2 -F



