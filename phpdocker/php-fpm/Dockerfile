FROM phpdockerio/php72-fpm
WORKDIR "/application"

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        php7.2-common \
        php7.2-cli \
        php7.2-curl \
        php7.2-fpm \
        php7.2-json \
        php7.2-mbstring \
        php7.2-opcache \
        php7.2-readline \
        php7.2-xml \
        php7.2-xsl \
        php7.2-yaml \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
