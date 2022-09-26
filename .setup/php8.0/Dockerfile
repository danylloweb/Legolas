FROM php:8.0-fpm

# Variables
ENV DOCUMENT_ROOT /var/www/html
ENV TZ=America/Recife

# Install dependencies
RUN apt-get update && apt-get install -y \
        nginx \
        unzip \
        git \
        curl \
        libxml2-dev \
        libzip-dev \
        libmcrypt-dev \
        libxslt-dev \
        libmemcached-dev \
        libpng-dev \
    && docker-php-ext-install opcache \
    && pecl install memcached mcrypt redis mongodb apcu \
    && echo "extension=mongodb.so" > $PHP_INI_DIR/conf.d/mongo.ini \
    && docker-php-ext-enable memcached mcrypt opcache redis mongodb apcu \
    && docker-php-ext-configure gd  \
    && docker-php-ext-configure zip  \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install -j "$(nproc)" mysqli pdo_mysql intl zip xsl soap gd \
    && docker-php-source delete


# Set Timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Workdir
WORKDIR $DOCUMENT_ROOT

# Remove NGINX old
RUN rm -f /etc/nginx/conf.d/*

# Copy app and configs
COPY . $DOCUMENT_ROOT
COPY nginx.conf /etc/nginx/nginx.conf
COPY php.ini /usr/local/etc/php/conf.d/app.ini
COPY php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf
# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
#RUN composer install --no-dev --no-interaction --no-scripts

# Logs to stdout
#RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

# Expose port
EXPOSE 80

# Start APP
CMD ["nginx", "-g", "daemon off;"]
RUN chmod +x entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
