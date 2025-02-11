#!/bin/bash

# until mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "SHOW DATABASES;" > /dev/null 2>&1; do
#   echo "Aspettando MariaDB..."
#   sleep 2
# done

# Crea il wp-config.php se non esiste
if [ ! -f /var/www/html/wp-config.php ]; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  ./wp-cli.phar core download --allow-root
  ./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root
  ./wp-cli.phar core install --url=localhost --title=inception --admin_user=admin --admin_password=admin --admin_email=admin@admin.com --allow-root
fi

# Avvia PHP-FPM in modalità foreground
php-fpm8.2 -F
