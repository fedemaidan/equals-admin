FROM php:7.0.8-fpm

ENV COMPOSER_VERSION=1.1.3
ENV PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/sbin:/usr/sbin

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

RUN apt-get update \
 && apt-get install \
        git \
        unzip \
        zlib1g-dev \
        curl \
        --assume-yes \
        --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install pdo_mysql;
RUN docker-php-ext-install zip;

RUN apt-get -y update \
    && apt-get install -y libicu-dev\
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl;

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture)" \
 && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.6/gosu-$(dpkg --print-architecture).asc" \
 && gpg --verify /usr/local/bin/gosu.asc \
 && rm /usr/local/bin/gosu.asc \
 && chmod +x /usr/local/bin/gosu

RUN cd /usr/local/bin \
 && curl -sS https://getcomposer.org/installer | php -- --filename=composer --version=$COMPOSER_VERSION

WORKDIR /server

COPY ./composer.json /server/composer.json
COPY ./composer.lock /server/composer.lock
#COPY ./app/AppKernel.php /server/app/AppKernel.php
#COPY ./app/AppCache.php /server/app/AppCache.php
COPY ./app /server/app

RUN composer install --optimize-autoloader --no-scripts

COPY ./src /server/src
COPY ./web /server/web

RUN rm -rf /usr/local/etc/php-fpm.d/*
COPY ./docker/php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf

#RUN mkdir ./app/cache ./app/cache/dev ./app/cache/prod ./app/logs \
# && chown www-data:www-data -R ./ \
# && chmod 777 -R ./app/cache ./app/logs 


RUN mkdir app/cache app/cache/dev app/cache/prod app/logs \
 && chown www-data:www-data -R . \
 && chmod 777 -R app/cache app/logs 

VOLUME ["/var/log/php", "/server"]

CMD gosu www-data composer run-script docker-build \
 && php-fpm
