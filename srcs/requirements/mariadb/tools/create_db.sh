#!/bin/bash

#
service mariadb start
sleep 5 # wait for mariadb to start

# Create database
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

# Create user
mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant privileges
mariadb -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"

# Flush privileges
mariadb -e "FLUSH PRIVILEGES;"

# Restart mariadb
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Restart mariadb with new congfig in the background
mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'
