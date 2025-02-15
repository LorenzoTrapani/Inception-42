#!/bin/bash

echo "inizio wp"


cp /tmp/wp-config.php /var/www/wp-config.php

# Crea il wp-config.php se non esiste
if [ ! -f /var/www/wp-config.php ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  ./wp-cli.phar core download --allow-root
  ./wp-cli.phar config create \
    --dbname="$DB_NAME" \
    --dbuser="$DB_USER" \
    --dbpass="$DB_PASSWORD" \
    --dbhost="$DB_HOST" \
    --allow-root
  
  # Aggiunge automaticamente le chiavi segrete di WordPress
  wp_secret_keys=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
  echo "$wp_secret_keys" >> /var/www/html/wp-config.php

  # Installa WordPress
  ./wp-cli.phar core install \
   --url=localhost \
   --title=inception \
   --admin_user=admin \
   --admin_password=admin \
   --admin_email=admin@admin.com \
   --allow-root
fi

echo "wp installato"

# Avvia PHP-FPM in modalità foreground
php-fpm8.2 -F
