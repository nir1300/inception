#!/bin/bash

#wait for mariadb to be ready

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then #location correct?
#download worpress
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

#create wp-config.php

#install wp

#create additional user
fi




#start php-fpm in the foreground