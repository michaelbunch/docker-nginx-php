FROM michaelbunch/laravel:7.1
LABEL Maintainer="Michael Bunch <michael@caeynastudios.com>"

# Install developer packages
RUN apk --no-cache add php7-xdebug

# Configure PHP-FPM
RUN touch /tmp/xdebug.log
COPY configs/php-dev.ini /etc/php7/php.ini
