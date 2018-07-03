FROM michaelbunch/laravel:7.1
LABEL Maintainer="Michael Bunch <michael@caeynastudios.com>"

# Install Xdebug and other required packages
RUN apk --no-cache add \
    php7-xdebug \
    php7-iconv \
    php7-simplexml \
    php7-xmlwriter \
    php7-xml

# Configure Xdebug
RUN touch /tmp/xdebug.log
COPY configs/php-dev.ini /etc/php7/php.ini

# Install developer tools via Composer
RUN composer global require --no-suggest --no-interaction \
    "squizlabs/php_codesniffer=*" \
    phpstan/phpstan
