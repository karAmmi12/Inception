# Description : WordPress Dockerfile

# Base image
FROM debian:bullseye

# Installer les dependances
RUN		apt -y update && \
		apt install -y php && \
		PHP_VERSION=$(php -v | head -n 1 | cut -d " " -f 2 | cut -d "." -f 1,2) && \
		apt install -y \
			php-fpm \
			php-mysql \
			php-cli \
			php-mbstring \
			mariadb-client \
			curl && \
		rm -rf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
		mkdir -p /run/php

# Copier les fichiers de configuration
COPY	./tools/script.sh /tmp/script.sh
COPY	./conf/www.conf /tmp/www.conf


RUN		chmod 755 /tmp/script.sh

# Lancer le script
ENTRYPOINT	["sh", "/tmp/script.sh"]
