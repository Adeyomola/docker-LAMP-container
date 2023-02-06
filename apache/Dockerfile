FROM ubuntu/apache2
EXPOSE 80
RUN ["/bin/sh", "-c", "apt update && apt install libapache2-mod-php php-mysql -y && a2enmod rewrite && apachectl restart"]
