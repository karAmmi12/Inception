# Description : WordPress Dockerfile

# Base image
FROM debian:bullseye


# Installer les dependances
RUN     apt-get update -y && \
        apt-get upgrade -y && \
        apt-get install -y \
            php-fpm \
            php-mysql \
            php-cli \
            php-mbstring \
            mariadb-client  && \
        rm -rf /etc/php/7.4/fpm/pool.d/www.conf && \
        mkdir -p /run/php

# Copier 
COPY ./tools/script.sh /usr/local/bin/script.sh

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT [ "sh", "/usr/local/bin/script.sh" ]