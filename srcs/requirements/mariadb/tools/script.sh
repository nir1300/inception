#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
#required for cnf file

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initialize MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    cat << EOF > /tmp/setup.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $wordpress_db;
CREATE USER IF NOT EXISTS '$wp_user'@'%' IDENTIFIED BY '$wp_password';
GRANT ALL PRIVILEGES ON $wordpress_db.* TO '$wp_user'@'%';

CREATE USER IF NOT EXISTS '$wp_user'@'localhost' IDENTIFIED BY '$wp_password';
GRANT ALL PRIVILEGES ON $wordpress_db.* TO '$wp_user'@'localhost';

ALTER USER 'root'@'localhost' IDENTIFIED BY '$sql_root_pw';
FLUSH PRIVILEGES;
EOF
    mysqld --user=mysql --bootstrap < /tmp/setup.sql
    rm -f /tmp/setup.sql
else
    echo "Already initialized - skipping setup."
fi

exec mysqld --user=mysql
