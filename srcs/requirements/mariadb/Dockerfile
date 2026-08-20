## MARIADB DOCKERFILE

FROM debian:12.15

RUN apt-get update && apt-get install -y mariadb-server mariadb-client
# clear package caches to keep container image size small
RUN rm -rf /varlib/apt/lists/* 

EXPOSE 3306

COPY tools/script.sh /var/local/bin
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod +x /var/local/bin/script.sh
ENTRYPOINT ["/var/local/bin/script.sh"]



## CNF: mariadb 50-server.cnf
# https://mariadb.com/docs/server/server-management/install-and-upgrade-mariadb/configuring-mariadb/configuring-mariadb-with-option-files
# tells mariaDB daemon (mysqld) how to behave, where to store files and how to accept incoming connections

# specify system user account 
user = mysql
# port that mariadb listens to for database queries
port = 3306
# specify location of database files
datadir = /var/lib/myscl 
# listen on all network interfaces, external containers (e.g. workpress) can talk to it
bind-address = 0.0.0.0
