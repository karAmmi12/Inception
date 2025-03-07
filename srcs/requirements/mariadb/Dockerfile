# Description : MariaDB Dockerfile

# Base image
FROM debian:bullseye

# mise a jour du systeme
RUN     apt-get update -y && apt-get upgrade -y

# Installer les dependances
RUN     apt-get install -y \
            mariadb-server \
            mariadb-client && \
        mkdir -p /var/run/mysqld && \
        chown -R mysql:mysql /var/run/mysqld && \
        chown -R mysql:mysql /etc/mysql
           
COPY	./conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf
COPY	./conf/request.sql /tmp/request.sql
COPY	./tools/create_db.sh /tmp/create_db.sh
        
RUN		chown -R mysql:mysql /etc/mysql && \
        chown -R mysql:mysql /tmp/
        
        
USER	mysql
        
ENTRYPOINT	["sh", "/tmp/create_db.sh"]

