FROM php:8.3-apache

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Set Apache document root to the api folder
ENV APACHE_DOCUMENT_ROOT=/var/www/html/api

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' \
    /etc/apache2/sites-available/*.conf \
    /etc/apache2/apache2.conf \
    /etc/apache2/conf-available/*.conf

# Copy your project into the container
COPY . /var/www/html

# Set permissions for uploads
RUN mkdir -p /var/www/html/api/uploads && \
    chown -R www-data:www-data /var/www/html/api/uploads

EXPOSE 80