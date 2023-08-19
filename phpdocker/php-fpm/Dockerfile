FROM phpdockerio/php:8.1-fpm
WORKDIR "/application"

RUN apt-get update \
    && apt-get -y --no-install-recommends install \
        php8.1-bz2 \ 
        php8.1-gd \ 
        php8.1-imagick \ 
        php8.1-imap \ 
        php8.1-intl \ 
        php8.1-ldap \ 
        php8.1-mcrypt \ 
        php8.1-memcache \ 
        php8.1-memcached \ 
        php8.1-mysql \ 
        php8.1-odbc \ 
        php8.1-phpdbg \ 
        php8.1-pspell \ 
        php8.1-soap \ 
        php8.1-ssh2 \ 
        php8.1-tidy \ 
        php8.1-uuid \ 
        php8.1-xdebug \ 
        php8.1-xmlrpc \ 
        php8.1-xsl \ 
        php8.1-yaml \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
