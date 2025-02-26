FROM debian:bullseye

# mise a jour systeme
RUN apt-get update && apt-get upgrade -y

# installation des packages
RUN apt-get install -y nginx openssl

# creation du dossier pour les certificats
RUN mkdir -p /etc/nginx/ssl

# Generation du certificat
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN='${USER}'"

# copie du fichier de configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# creation du dossier pour les sites
# RUN mkdir -p /var/www/worpress

RUN chmod 755 /var/www/html

# changer le proprietaire du dossier
RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]

