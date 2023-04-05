#/bin/sh

# Install build tools
apk add sudo alpine-sdk autoconf
apk add curl-dev libxml2-dev libzip-dev libpng-dev oniguruma-dev

# Install APCu
echo no | pecl install apcu
docker-php-ext-enable apcu

# Install 'igbinary' package for redis
pecl install igbinary
docker-php-ext-enable igbinary

# Install redis
yes | pecl install redis
docker-php-ext-enable redis

# Install other dependencies
docker-php-ext-install \
    curl \
    gd \
    mbstring \
    mysqli \
    pdo \
    pdo_mysql \
    simplexml \
    zip

# Cleanup
apk del alpine-sdk autoconf
rm -rf /var/cache/apk/*

# Ensure user with uid=33 exists
getent passwd 33
if [ $? -eq 0 ];
then
    echo "User with UID 33 already exists, skip user creation."
else
    adduser -s /sbin/nologin -H -D -u 33 nxc-cron-runner
fi

# Add rule for crontab
echo "*/5 * * * * /root/nxc-cron.sh" >> /etc/crontabs/root
