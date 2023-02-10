FROM php:8.1-cli as php
COPY ./app_link /app_link
COPY ./scripts/env_editor.sh /usr/local/bin/
COPY ./secrets/ /secrets/
RUN ["/bin/bash", "-c", "apt update -y && apt install git zlib1g-dev libzip-dev libpng-dev -y \
&& git clone $(cat /app_link) /app && rm -rf /app_link && curl https://getcomposer.org/installer| php \
&& mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer"]
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath zip gd calendar sockets
WORKDIR /app/
RUN ["/bin/bash", "-c", "composer create-project && env_editor.sh && rm -rf /secrets"]

FROM mariadb:10.9.5-jammy
EXPOSE 80
EXPOSE 3306
COPY --from=php /app/ /var/www/html/app/
COPY ./apache/app.conf /etc/apache2/sites-enabled/000-default.conf
COPY ./secrets /secrets/
COPY ./scripts/createdb.sh /usr/local/bin/
HEALTHCHECK --retries=3 --timeout=60s CMD mysqladmin ping -h localhost
ENV MYSQL_ROOT_PASSWORD_FILE=/secrets/mysql_root MYSQL_DATABASE_FILE=/secrets/mysql_db \
MYSQL_USER_FILE=/secrets/mysql_user MYSQL_PASSWORD_FILE=/secrets/mysql_password
RUN ["/bin/bash", "-c", "apt update -y && apt install php8.1 php8.1-mysql apache2 -y \
&& echo ServerName 127.0.0.1 >> /etc/apache2/apache2.conf && a2enmod rewrite && service apache2 start"]
WORKDIR /var/www/html/app/
RUN ["/bin/bash", "-c", "chown www-data:www-data -R /var/www/html/app/ && chmod 755 -R /var/www/html/app/"]
ENTRYPOINT ["/bin/bash", "-c", "service apache2 start && mysql_install_db --user=mysql && service mariadb start \
&& createdb.sh && php artisan migrate:refresh --seed && rm -rf /secrets/ && tail -f /dev/null"]
