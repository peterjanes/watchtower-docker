FROM composer:latest AS composer
FROM alpine/git:latest AS git

LABEL stage=intermediate
WORKDIR /clone-workspace
RUN git clone https://github.com/aaronpk/Watchtower.git .
COPY scripts/configure.sh configure.sh
RUN ./configure.sh

FROM php:7.4-fpm-alpine
WORKDIR /app

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=git --chown=www-data:www-data /clone-workspace .

COPY files/opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY scripts/entrypoint.sh entrypoint.sh
RUN docker-php-ext-install opcache pcntl pdo_mysql && \
    composer install

ENTRYPOINT ["/app/entrypoint.sh"]
