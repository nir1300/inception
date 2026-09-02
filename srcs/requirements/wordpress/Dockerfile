FROM debian:bookworm

#download php-fpm
RUN apt-get update && apt-get install -y php-fpm php-mysql curl

EXPOSE 9000


#copy www.conf file

#copy script and launch
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

#download worpress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

ENTRYPOINT ["/usr/local/bin/script.sh"]

