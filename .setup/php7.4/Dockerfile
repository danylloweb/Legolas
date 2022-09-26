FROM php:7.4-fpm

# Variables
ENV DOCUMENT_ROOT /var/www/html
ENV TZ=America/Sao_Paulo

# Install dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    htop \
    nano \
    libpq-dev \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_pgsql mbstring exif pcntl bcmath gd sockets pdo_mysql
# Install redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

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

# Expose port
EXPOSE 80

# Start APP
CMD ["nginx", "-g", "daemon off;"]
RUN chmod +x entrypoint.sh
#ENTRYPOINT ["entrypoint.sh"]
