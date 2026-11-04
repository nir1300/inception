FROM debian:bookworm

#install required packes
RUN apt-get update && apt-get install -y mariadb-server mariadb-client

# clear package caches to keep container image size small
RUN rm -rf /var/lib/apt/lists/* 

#make port available to other containers on the docker network, not reachable by outside world
EXPOSE 3306

# copy script and configuration file (my config overwrites default)
COPY tools/script.sh /usr/local/bin/script.sh
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#make script executable
RUN chmod +x /usr/local/bin/script.sh

#what runs when container starts
ENTRYPOINT ["/usr/local/bin/script.sh"]

