FROM php:8.1-apache-bullseye
EXPOSE 80
COPY ./app_link /app_link
COPY ./scripts/env_editor.sh /usr/local/bin/
COPY ./app.conf /etc/apache2/sites-enabled/000-default.conf
RUN ["/bin/bash", "-c", "apt update -y && apt install git wget zlib1g-dev libzip-dev libpng-dev -y \
&& git clone $(cat /app_link) /var/www/html/app && rm -rf /app_link \
&& wget -O /usr/local/bin/composer https://getcomposer.org/download/2.4.4/composer.phar \
&& chmod +x /usr/local/bin/composer && echo 'error_log = /var/log/php.log' >> /usr/local/etc/php/php.ini-development"]
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath zip gd
WORKDIR /var/www/html/app
ENTRYPOINT ["/bin/bash", "-c", "a2enmod rewrite && service apache2 restart && composer create-project \
&& env_editor.sh && php artisan migrate:refresh --seed \
&& chmod 755 -R /var/www/html/app && chown www-data:www-data -R /var/www/html/app && tail -f /dev/null"]
