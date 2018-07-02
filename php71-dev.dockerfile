FROM michaelbunch/laravel:7.1
LABEL Maintainer="Michael Bunch <michael@caeynastudios.com>"

# Install developer packages
RUN apk --no-cache add php7-xdebug

# Install Blockfire.io Probe
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") && \
    curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/alpine/amd64/$version && \
    tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp && \
    mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so && \
    printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

# Configure PHP-FPM
RUN touch /tmp/xdebug.log
COPY configs/php-dev.ini /etc/php7/php.ini
