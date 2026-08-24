#!/bin/bash
if [! -e /var/lib/mysql/db]; then
    echo "Initialize MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
    cat << EOF > /tmp/setup.sql
CREATE DADABASE IF NOT EXISTS $wordpress_db;
CREATE USER $wp_user IDENTIFIED BY $wp_password;
GRANT ALL PRIVILEGES ON $wordpress_db.* TO $wp_user'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$sql_root_pw';
FLUSH PRIVILIGES;
EOF
    mysqld --user=mysql --bootstrap < /tmp/init.sql
    rm -f /tmp/setup.sql
fi

exec mysqld --user=mysql
