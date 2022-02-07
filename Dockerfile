FROM php:8.1-fpm-alpine
ARG APP_ENV

COPY docker/entrypoint.sh /usr/local/bin/

RUN apk update && apk --no-cache add \
    autoconf \
    curl \
    zip \
    unzip \
    postgresql-dev \
    icu-dev \
    rabbitmq-c rabbitmq-c-dev \
    g++ \
    make

RUN pecl install amqp-beta pcov \
    && docker-php-ext-install pdo_pgsql bcmath intl \
    && docker-php-ext-enable amqp pcov \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
