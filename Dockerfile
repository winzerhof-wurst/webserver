FROM php:7.1.15-apache-jessie
COPY apache.conf /etc/apache2/sites-available/wiwu.conf
COPY ports.conf /etc/apache2/ports.conf
RUN apt-get update && apt-get install -y --no-install-recommends \
    libmcrypt-dev \
    mysql-client \
    && docker-php-ext-install mcrypt pdo_mysql \
    && a2enmod rewrite \
    && a2dissite 000-default.conf \
    && a2ensite wiwu.conf
WORKDIR /var/www
RUN chgrp -R 0 /var/run/apache2 \
    && chgrp -R 0 /var/lock/apache2 \
    && chmod -R g=u /var/run/apache2 \
    && chmod -R g=u /var/lock/apache2
USER 1001
EXPOSE 8080

