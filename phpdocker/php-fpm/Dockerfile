FROM phpdockerio/php72-fpm
WORKDIR "/application"

RUN docker-php-ext-install bcmath && docker-php-ext-enable bcmath && \
        docker-php-ext-install bz2 && docker-php-ext-enable bz2 && \
        docker-php-ext-install cli && docker-php-ext-enable cli && \
        docker-php-ext-install common && docker-php-ext-enable common && \
        docker-php-ext-install curl && docker-php-ext-enable curl && \
        docker-php-ext-install fpm && docker-php-ext-enable fpm && \
        docker-php-ext-install gd && docker-php-ext-enable gd && \
        docker-php-ext-install imap && docker-php-ext-enable imap && \
        docker-php-ext-install intl && docker-php-ext-enable intl && \
        docker-php-ext-install json && docker-php-ext-enable json && \
        docker-php-ext-install mbstring && docker-php-ext-enable mbstring && \
        docker-php-ext-install mysql && docker-php-ext-enable mysql && \
        docker-php-ext-install opcache && docker-php-ext-enable opcache && \
        docker-php-ext-install pspell && docker-php-ext-enable pspell && \
        docker-php-ext-install pdo_mysql && docker-php-ext-enable pdo_mysql && \
        docker-php-ext-install mysqli && docker-php-ext-enable mysqli && \
        docker-php-ext-install readline && docker-php-ext-enable readline && \
        docker-php-ext-install soap && docker-php-ext-enable soap && \
        docker-php-ext-install sqlite3 && docker-php-ext-enable sqlite3 && \
        docker-php-ext-install tidy && docker-php-ext-enable tidy && \
        docker-php-ext-install xml && docker-php-ext-enable xml && \
        docker-php-ext-install xmlrpc && docker-php-ext-enable xmlrpc && \
        docker-php-ext-install xsl && docker-php-ext-enable xsl && \
        docker-php-ext-install yaml && docker-php-ext-enable yaml && \
        docker-php-ext-install zip && docker-php-ext-enable zip \

RUN apt-get update \
    && apt-get -y --no-install-recommends install git vim mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN docker-php-ext-install pdo pdo_mysql

RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
