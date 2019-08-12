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
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

# Install Xdebug
RUN apk add --update --no-cache $PHPIZE_DEPS && \
    pecl install xdebug-2.7.2 && \
    docker-php-ext-enable xdebug && \
    echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && \
    echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Install Composer
ADD scripts/install_composer.sh /usr/local/bin/install_composer.sh
RUN chmod 755 /usr/local/bin/install_composer.sh && \
    /usr/local/bin/install_composer.sh && \
    mv composer.phar /usr/local/bin/composer

RUN mkdir -p /app

WORKDIR /app
