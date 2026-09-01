FROM debian:bookworm

#download php-fpm
RUN apt-get update && apt-get install -y php-fpm php-mysql curl

EXPOSE 9000


#copy www.conf file

#copy script and launch
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh


ENTRYPOINT ["/usr/local/bin/script.sh"]

