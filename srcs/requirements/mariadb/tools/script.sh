#!/bin/bash

#this runs every time container starts

#create runtime folder, failes without mysql
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

#check if database was already initialised
if [ ! -d "/var/lib/mysql/$db_name" ]; then
    echo "Initialize MariaDB..."
    # create data directory and system tables
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    #write tmp sql file: creates WP database, creates WP user and pw, gives full rights, creates user twice (% for any host and one for localhost)
    cat << EOF > /tmp/setup.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $db_name;
CREATE USER IF NOT EXISTS '$db_user'@'%' IDENTIFIED BY '$db_password';
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'%';
CREATE USER IF NOT EXISTS '$db_user'@'localhost' IDENTIFIED BY '$db_password';
GRANT ALL PRIVILEGES ON $db_name.* TO '$db_user'@'localhost';

ALTER USER 'root'@'localhost' IDENTIFIED BY '$sql_root_pw';
FLUSH PRIVILEGES;
EOF
    #run sql file, delete afterwards so pw are safe
    mysqld --user=mysql --bootstrap < /tmp/setup.sql
    rm -f /tmp/setup.sql
else
    echo "Already initialized - skipping setup."
fi

#start database server, exec replaces shell with mysqld -> becomes PID1
#daemon is the main process -> in the background would be mysqld &
exec mysqld --user=mysql
