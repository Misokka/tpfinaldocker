FROM nginx:alpine

RUN apk add --no-cache \
    php \
    php-fpm \
    php-pdo_mysql \
    php-mbstring \
    php-exif \
    php-pcntl \
    php-bcmath \
    php-gd \
    php-fileinfo \
    php-tokenizer \
    php-dom \
    php-xml \
    php-xmlwriter \
    php-session

RUN apk update && apk upgrade

RUN apk add composer nodejs npm

EXPOSE 9000

WORKDIR /app/

COPY dockernginx /app

COPY nginx.conf /etc/nginx/nginx.conf

COPY .env /app

RUN composer install

RUN npm install

RUN php artisan key:generate

RUN apk add dos2unix

COPY setup.sh /setup.sh

RUN chmod +x /setup.sh

RUN dos2unix /setup.sh

CMD ["/setup.sh"]
