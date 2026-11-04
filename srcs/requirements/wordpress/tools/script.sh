#!/bin/bash

#wait for mariadb to be ready
until mariadb-admin ping -h"mariadb" -P 3306 --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then

    #install wp, copies wp files into /var/www/html
    wp core download --allow-root

     #create wp-config.php to connect php to the mariadb database
    wp config create --dbname=$db_name --dbuser=$db_user --dbpass=$db_password --dbhost=mariadb:3306 --allow-root

    #run the install, create administrator
    wp core install --url=$wp_url --title=$wp_title --admin_user=$wp_admin_user --admin_password=$wp_admin_pw --admin_email=$wp_admin_email --allow-root
    #create additional user
    wp user create $wp_user $wp_user_email --user_pass=$wp_user_pw --role=author --allow-root
    # install and activate theme
    wp theme install twentytwentyone --allow-root
    wp theme activate twentytwentyone  --allow-root
    wp option update fresh_site 0 --allow-root

fi


#start php-fpm in the foreground (-F) as PID1 (otherwise it would exit)
exec php-fpm8.2 -F
