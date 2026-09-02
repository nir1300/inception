#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
#required for cnf file

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initialize MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
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
    mysqld --user=mysql --bootstrap < /tmp/setup.sql
    rm -f /tmp/setup.sql
else
    echo "Already initialized - skipping setup."
fi

exec mysqld --user=mysql
