FROM ubuntu/apache2:2.4-22.04_edge
RUN ["/bin/sh", "-c", "apt update -y && apt install php-mysql libapache2-mod-php -y && a2enmod rewrite \
&& apachectl restart"]
EXPOSE 80
