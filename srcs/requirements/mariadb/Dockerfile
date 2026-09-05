FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server mariadb-client
# clear package caches to keep container image size small
RUN rm -rf /var/lib/apt/lists/* 

EXPOSE 3306

COPY tools/script.sh /usr/local/bin/script.sh
# copy configuration file to overwrite default with my own
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /usr/local/bin/script.sh
ENTRYPOINT ["/usr/local/bin/script.sh"]
