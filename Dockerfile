FROM php:7.1-apache-jessie
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
RUN chown -R www-data:www-data /var/run/apache2 \
    && chown -R www-data:www-data /var/lock/apache2 \
    && chmod -R a+rwx /var/run/apache2 \
    && chmod -R a+rwx /var/lock/apache2
USER www-data
EXPOSE 8080

