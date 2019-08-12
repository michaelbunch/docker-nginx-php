FROM php:7.3-fpm-alpine

RUN apk add --update --no-cache \
        zlib-dev \
        libxpm-dev \
        libzip-dev \
        && \
    docker-php-ext-install \
        bcmath \
        pdo \
        pdo_mysql \
        zip

# Configure PHP.ini
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# Install Composer
ADD scripts/install_composer.sh /usr/local/bin/install_composer.sh
RUN chmod 755 /usr/local/bin/install_composer.sh && \
    /usr/local/bin/install_composer.sh && \
    mv composer.phar /usr/local/bin/composer

RUN mkdir -p /app

WORKDIR /app
