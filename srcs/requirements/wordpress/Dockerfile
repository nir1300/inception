FROM debian:bookworm

#download php-fpm
RUN apt-get update && apt-get install -y php-fpm php-mysql curl mariadb-client

EXPOSE 9000


#copy www.conf file
COPY conf/www.config /etc/php/8.2/fpm/pool.d/www.conf

#copy script and launch
COPY tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

#download worpress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php

ENTRYPOINT ["/usr/local/bin/script.sh"]

#### VM HAS THIS:
# FROM debian:bookworm

# # Install required PHP extensions and tools (no database server)
# RUN apt-get update && apt-get install -y \
#     php8.2-fpm \
#     php8.2-mysql \
#     curl \
#     mariadb-client \
#     && rm -rf /var/lib/apt/lists/*

# # Create PID run folder for PHP-FPM
# RUN mkdir -p /run/php

# # Copy custom FPM pool config
# COPY tools/www.config /etc/php/8.2/fpm/pool.d/www.conf

# # Install WP-CLI
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp

# # Copy entrypoint script
# COPY tools/script.sh /usr/local/bin/script.sh
# RUN chmod +x /usr/local/bin/script.sh

# EXPOSE 9000

# ENTRYPOINT ["/usr/local/bin/script.sh"]