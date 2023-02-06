FROM php:8.1-cli
RUN ["/bin/bash", "-c", "apt update -y && apt install zlib1g-dev libzip-dev libpng-dev -y && curl https://getcomposer.org/installer| php \
&& mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer"]
RUN docker-php-ext-install pdo pdo_mysql mysqli bcmath zip gd calendar sockets
WORKDIR /laravel-realworld-example-app
USER www-data:www-data
ENTRYPOINT ["/bin/bash", "-c", "composer create-project && php artisan migrate:refresh --seed \
&& chmod 755 -R /laravel-realworld-example-app"]
