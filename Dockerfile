FROM php:7.1-fpm

RUN apt-get update \
    && apt-get -y install libzip-dev

RUN docker-php-ext-install pdo_mysql

RUN pecl install xdebug \
    && pecl install zip

RUN docker-php-ext-enable xdebug zip

# COPY conf/php.ini /etc/php/7.1/fpm/conf.d/40-custom.ini
