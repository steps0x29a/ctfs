FROM php:7.2-apache
RUN apt update && apt install -y git libssl-dev
RUN pecl install mongodb && docker-php-ext-enable mongodb
RUN echo "extension=mongodb.so" >> /usr/local/etc/php/conf.d/mongodb.ini