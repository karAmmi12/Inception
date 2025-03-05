#!/bin/bash

# Update the request.sql file
sed -i 's|{{WORDPRESS_DB_NAME}}|'${WORDPRESS_DB_NAME}'|g' /tmp/request.sql
sed -i 's|{{WORDPRESS_DB_USER}}|'${WORDPRESS_DB_USER}'|g' /tmp/request.sql
sed -i 's|{{WORDPRESS_DB_PASSWORD}}|'${WORDPRESS_DB_PASSWORD}'|g' /tmp/request.sql
sed -i 's|{{MYSQL_ROOT_PASSWORD}}|'${MYSQL_ROOT_PASSWORD}'|g' /tmp/request.sql

# Update the my.cnf file
sed -i 's|{{MYSQL_PORT}}|'${MYSQL_PORT}'|g' /etc/mysql/mariadb.conf.d/my.cnf
sed -i 's|{{MYSQL_ADRRESS}}|'${MYSQL_ADRRESS}'|g' /etc/mysql/mariadb.conf.d/my.cnf

if [ -d "/var/lib/mysql/$WORDPRESS_DB_NAME" ]; then
	echo "WordPress already installed"
	mysqld_safe
else
	mysql_install_db
	mysqld --init-file="/tmp/request.sql"
fi