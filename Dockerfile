FROM php:7.1-fpm

RUN apt-get update \
    && apt-get -y install libzip-dev

RUN docker-php-ext-install pdo_mysql

RUN pecl install xdebug \
    && pecl install zip

RUN docker-php-ext-enable xdebug zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

RUN composer global require "laravel/installer"

ENV PATH="~/.composer/vendor/bin:${PATH}"

# COPY conf/php.ini /etc/php/7.1/fpm/conf.d/40-custom.ini
