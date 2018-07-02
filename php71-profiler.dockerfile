FROM michaelbunch/laravel:7.1
LABEL Maintainer="Michael Bunch <michael@caeynastudios.com>"

# Install Blackfire requirements
RUN apk --no-cache add curl

# Install Blackfire.io Probe
COPY scripts/install_blackfire.sh /root
RUN chmod 775 /root/install_blackfire.sh && \
    /root/install_blackfire.sh && \
    rm /root/install_blackfire.sh
