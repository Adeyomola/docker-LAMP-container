FROM php:8.1-apache-bullseye

EXPOSE 80

COPY ./app_link /app_link
COPY ./scripts/env_editor.sh /usr/local/bin/
COPY ./app.conf /etc/apache2/sites-enabled/000-default.conf

ENV webroot=/var/www/html/app
ENV phplog=/var/log/php.log

ARG download_composer=https://getcomposer.org/download/2.4.4/composer.phar
ARG composer_dest=/usr/local/bin/composer


VOLUME $phplog
RUN ["/bin/bash", "-c", "apt update -y && apt install git wget zlib1g-dev libzip-dev libpng-dev -y \
&& git clone $(cat /app_link) $webroot && rm -rf /app_link && wget -O $composer_dest $download_composer \
&& chmod +x $composer_dest && echo 'error_log = $phplog' >> /usr/local/etc/php/php.ini-development \
&& echo 'error_log = ${phplog}' >> /usr/local/etc/php/php.ini-production && touch $phplog"]
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath zip gd

WORKDIR $webroot

ENTRYPOINT ["/bin/bash", "-c", "a2enmod rewrite && chown www-data:www-data $phplog \
&& service apache2 restart && composer create-project && env_editor.sh && php artisan migrate:refresh --seed \
&& chmod 755 -R $webroot && chown www-data:www-data -R $webroot && tail -f /dev/null"]
