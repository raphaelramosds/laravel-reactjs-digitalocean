FROM composer:2.7.7 AS composer-stage
WORKDIR /app
COPY composer.json composer.lock ./
RUN /usr/bin/composer install --prefer-dist --no-cache --no-dev --no-scripts

FROM node:22-alpine AS node-stage
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install --progress=false --no-audit --omit=dev

FROM serversideup/php:8.4-fpm-nginx-alpine AS production

ENV AUTORUN_ENABLED=true

ARG UID=82
ARG GID=82

USER root

RUN /usr/local/bin/docker-php-serversideup-set-id www-data ${UID}:${GID} && \
    /usr/local/bin/docker-php-serversideup-set-file-permissions --owner ${UID}:${GID} --service nginx
   
RUN /sbin/apk add --no-cache npm

WORKDIR /var/www/html

COPY --chown=www-data:www-data . .

COPY --from=composer-stage /usr/bin/composer /usr/bin/composer
COPY --chown=www-data:www-data --from=composer-stage /app/vendor ./vendor
COPY --chown=www-data:www-data --from=node-stage /app/node_modules ./node_modules

RUN /usr/bin/composer install --no-dev --optimize-autoloader

COPY --chmod=755 ./entrypoint.d/ /etc/entrypoint.d/

USER www-data
