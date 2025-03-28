# FROM phpdockerio/php72-fpm
FROM phpdockerio/php74-fpm
WORKDIR "/application"

RUN apt-get update && apt-get upgrade -y

RUN apt-get clean && apt-get update && apt-get install -y sudo locales

RUN sudo localedef -i en_US -f UTF-8 en_US.UTF-8
RUN sudo localedef -i ru_RU -f UTF-8 ru_RU.utf8
RUN sudo localedef -i uk_UA -f UTF-8 uk_UA.utf8

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'ru_UA.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'uk_UA.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'uk_UA KOI8-U' >> /etc/locale.gen

RUN sudo locale-gen

RUN sudo update-locale LANG=en_US.UTF-8

RUN apt-get remove -y php* \
    && apt-get autoremove -y \
    && apt-get update \
    && apt-get -y --no-install-recommends install git vim mysql-client php7.4-common php7.4-readline \
    && apt-get -y --no-install-recommends install php7.4-bcmath php7.4-bz2 \
    && apt-get -y --no-install-recommends install php7.4-cli php7.4-curl \
    && apt-get -y --no-install-recommends install php7.4-gd php7.4-fpm \
	&& apt-get -y --no-install-recommends install php7.4-pdo php7.4-mysql \
	&& apt-get -y --no-install-recommends install php7.4-intl php7.4-json \
	&& apt-get -y --no-install-recommends install php7.4-mbstring php7.4-opcache \
	&& apt-get -y --no-install-recommends install php7.4-pspell php7.4-soap \
	&& apt-get -y --no-install-recommends install php7.4-sqlite3 php7.4-tidy \
	&& apt-get -y --no-install-recommends install php7.4-xml php7.4-xmlrpc php7.4-xsl \
	&& apt-get -y --no-install-recommends install php7.4-yaml php7.4-zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
