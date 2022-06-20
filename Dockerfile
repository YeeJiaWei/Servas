FROM composer AS application_builder
WORKDIR /app

COPY . ./

RUN mkdir -p storage/framework/cache \
    && mkdir -p storage/framework/views \
    && mkdir -p storage/framework/sessions \
    && composer install --optimize-autoloader --no-dev


FROM node:17.4-alpine As asset_builder
WORKDIR /app

COPY ./package.json ./
COPY ./package-lock.json ./
COPY ./webpack.mix.js ./
COPY ./webpack.config.js ./
COPY ./tailwind.config.js ./
COPY ./resources ./resources

RUN npm install \
    && npm run prod


FROM php:fpm-alpine
WORKDIR /var/www/html

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install opcache \
    && apk add --no-cache \
    mariadb-client \
    sqlite \
    nginx

COPY . ./

COPY --from=application_builder /app/vendor ./vendor
COPY --from=application_builder /app/bootstrap/cache ./bootstrap/cache

COPY --from=asset_builder /app/public/assets ./public/assets
COPY --from=asset_builder /app/public/css ./public/css
COPY --from=asset_builder /app/public/js ./public/js
COPY --from=asset_builder /app/public/mix-manifest.json ./public/mix-manifest.json

RUN chown -R www-data: /var/www/html \
    && rm -rf ./docker

COPY ./docker/config/servas-php.ini /usr/local/etc/php/conf.d/servas-php.ini
COPY ./docker/config/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/config/site-nginx.conf /etc/nginx/http.d/default.conf

EXPOSE 80

CMD php-fpm -D && nginx -g 'daemon off;'