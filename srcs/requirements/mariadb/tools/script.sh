# mysql_install_db -> init mysql data directory
# download on install mariadb on container, create root user
# cmd: give all priviliages to root user (GRANT)

#!/usr/bin/bash
if [! -e /var/lib/mysql/db]
	then
		#first startup
		
fi

exec mysqld_safe --user=mysql --datadir=/var/lib/mysql

CREATE DADABASE IF NOT EXISTS



<<comment



Check for existing data: Use a Bash if test checking if the database folder exists in /var/lib/mysql/. This prevents overwriting your data every time the container restarts.

mariadb-install-db / mysql_install_db: Initializes the system data directory and creates internal system tables (like permissions and schemas).

mysqld_safe &: Starts the MariaDB daemon temporarily in the background so SQL setup commands can be executed.

mariadb-admin ping / mysqladmin ping: A loop check used with sleep to pause the script until the background server is fully booted up and ready to accept SQL queries.

SQL Input Execution (via mariadb or mysql client):

    ALTER USER / SET PASSWORD: Sets a secure password for the root administrative user.

    CREATE DATABASE: Creates the WordPress database schema.

    CREATE USER: Creates the non-root database user assigned to WordPress (e.g., 'username'@'%' so it can connect from any host inside the network).

    GRANT ALL PRIVILEGES: Gives the new WordPress user permissions over the created database.

    FLUSH PRIVILEGES: Forces MariaDB to reload user privilege tables immediately.

mariadb-admin shutdown: Gracefully turns off the temporary background MariaDB process.

exec mysqld_safe: Launches the main database server process as PID 1 in the foreground, keeping the Docker container alive and running indefinitely.

+-----------------------------------------------------------------+
|                         mariadb.sh                              |
|                                                                 |
|  1. Check if database exists in /var/lib/mysql                  |
|     ├── IF NO:                                                  |
|     │    ├── Run initial database setup (mariadb-install-db)    |
|     │    ├── Start server in background (mysqld_safe &)         |
|     │    ├── Wait for database to respond (mariadb-admin ping)  |
|     │    ├── Run SQL script to create DB & Users                |
|     │    └── Stop background server cleanly                     |
|     └── IF YES: Skip setup (persisted volume)                   |
|                                                                 |
|  2. Launch database daemon in FOREGROUND (exec mysqld_safe)     |
+-----------------------------------------------------------------+

comment

