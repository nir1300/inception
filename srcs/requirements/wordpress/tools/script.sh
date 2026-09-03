#!/bin/bash

#wait for mariadb to be ready
# until mariadb-admin ping -h"mariadb" --silent; do
#     echo "Waiting for MariaDB..."
#     sleep 2
# done

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then #location correct?

    #install wp
    wp core download --allow-root

     #create wp-config.php to connect php to mariadb
    wp config create --dbname=$db_name --dbuser=$db_user --dbpass=$db_password --dbhost=mariadb:3306 --allow-root

    #create administrator
    wp core install --url=$wp_url --title=$wp_title --admin_user=$wp_admin_user --admin_password=$wp_admin_pw --admin_email=$wp_admin_email --allow-root
    #create additional user
    wp user create $wp_user $wp_user_email --user_pass=$wp_user_pw --role=author --allow-root
fi

#start php-fpm in the foreground
exec php-fpm8.2 -F

#daemonize?