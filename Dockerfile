FROM php:8.1-apache-bullseye

HEALTHCHECK --retries=3 --timeout=60s CMD curl localhost
EXPOSE 80

COPY ./scripts/env_editor.sh /usr/local/bin/
COPY ./app.conf /etc/apache2/sites-enabled/000-default.conf

ENV webroot=/var/www/html/app
ENV phplog=/var/log/php.log

ARG repo_url=https://github.com/f1amy/laravel-realworld-example-app.git
ARG download_composer=https://getcomposer.org/download/2.4.4/composer.phar
ARG composer_dest=/usr/local/bin/composer

# Install git composer and other tools.
# PHP log file in php.ini. Then create phplog file and change its owner
RUN ["/bin/bash", "-c", "apt update -y && apt install git wget zlib1g-dev libzip-dev libpng-dev -y \
&& git clone $repo_url $webroot \
&& wget -O $composer_dest $download_composer && chmod +x $composer_dest \
&& echo 'error_log = $phplog' >> /usr/local/etc/php/php.ini-development \
&& echo 'error_log = $phplog' >> /usr/local/etc/php/php.ini-production \
&& echo 'ServerName 127.0.0.1' >> /etc/apache2/apache2.conf \
&& a2enmod rewrite && touch $phplog && chown www-data:www-data $phplog"]

# install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath zip gd

WORKDIR $webroot
RUN ["/bin/bash", "-c", "composer create-project && chmod 755 -R $webroot && chown www-data:www-data -R $webroot"]

ENTRYPOINT ["/bin/bash", "-c", "env_editor.sh && service apache2 restart && php artisan migrate:refresh --seed \
&& tail -f /dev/null"]
