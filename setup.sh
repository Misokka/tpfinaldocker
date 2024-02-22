#!/bin/sh

php artisan config:clear
php artisan route:clear
php artisan view:clear

if [ "$SERVER_WEB_NAME" = "Server 1" ]; then
  php artisan migrate:fresh --seed
fi

npm run build

php artisan serve --host=0.0.0.0 --port=80