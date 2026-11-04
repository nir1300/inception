FROM debian:bookworm

#download php-fpm, php-mysql (needed so that PHP can talk to mariadb), mariadb-client (needed for the ping wait loop)
RUN apt-get update && apt-get install -y php-fpm php-mysql curl mariadb-client

#document fastCGI port
#make port available to other containers on the docker network, not reachable by outside world
EXPOSE 9000

#copy www.conf file, change name to end with .conf for php-fpm to load it
COPY conf/www.config /etc/php/8.2/fpm/pool.d/www.conf

#copy script and launch
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

#download worpress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

#create runtime folder for php-fpm
RUN mkdir -p /run/php

#run script
ENTRYPOINT ["/usr/local/bin/script.sh"]
