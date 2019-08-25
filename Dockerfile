FROM php:7.2-cli
COPY --from=composer:1.9.0 /usr/bin/composer /usr/bin/composer
WORKDIR /var/app