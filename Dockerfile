FROM composer:latest AS composer

FROM alpine/git:latest AS intermediate
WORKDIR /clone-workspace
RUN git clone https://github.com/aaronpk/Watchtower.git .

FROM php:7.4-fpm-alpine
COPY --from=intermediate /clone-workspace .

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN docker-php-ext-install opcache pcntl pdo_mysql \
    && apk --update add --no-cache git

COPY files/opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY scripts/configure.sh configure.sh
RUN ./configure.sh

CMD ["php-fpm"]
