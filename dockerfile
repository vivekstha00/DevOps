FROM php:8.2-fpm
# Set working directory
WORKDIR /var/www
# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip
# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd
# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
# Copy existing application code
COPY . /var/www

# Change current user to www-data
USER www-data

# Expose port 9000
EXPOSE 9000

CMD ["php-fpm"]
