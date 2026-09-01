#!/bin/bash

#wait for mariadb to be ready

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then #location correct?
#download worpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

#create wp-config.php
wp config create --dbname=$wp_user --dbpass=$wp_password --dbhost=mariadb:3306

#install wp
wp core download --allow-root
#create additional user
wp user create >
fi




#start php-fpm in the foreground
exec php-fpm8.2 -F