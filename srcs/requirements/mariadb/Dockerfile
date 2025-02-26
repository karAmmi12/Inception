# Description : MariaDB Dockerfile

# Base image
FROM debian:bullseye

# mise a jour du systeme
RUN     apt-get update -y && apt-get upgrade -y

# Installer les dependances
RUN     apt-get install -y \
            mariadb-server \
            mariadb-client 
           

# Copier les fichiers de configuration
COPY ./conf/my.cnf /etc/mysql/my.cnf

# Copier le script de creation de la base de donnees
COPY ./tools/create_db.sh /create_db.sh

RUN chmod +x /create_db.sh

ENTRYPOINT [ "./create_db.sh" ]


# Explanation:
# The MariaDB Dockerfile is similar to the Nginx Dockerfile. It starts with the same base image, debian:bullseye, and updates the system. It then installs the MariaDB server and netcat. The configuration files are copied to the appropriate directories, and the script to create the database is copied to the root directory. The script is made executable, and the entry point is set to run the script when the container starts. This script will create the database and user for the WordPress application to use. 
# The MariaDB container is now ready to be built and run.