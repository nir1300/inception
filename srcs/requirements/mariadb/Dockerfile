## MARIADB DOCKERFILE

FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server mariadb-client
# clear package caches to keep container image size small
RUN rm -rf /var/lib/apt/lists/* 

EXPOSE 3306

COPY tools/script.sh /usr/local/bin/script.sh
# copy configuration file to overwrite default with my own
COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /usr/local/bin/script.sh
ENTRYPOINT ["/usr/local/bin/script.sh"]



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
