#! /bin/bash

sed -i 's|APP_URL.\+|APP_URL=http://localhost|' .env
sed -i 's/APP_PORT.\+/#APP_PORT/' .env
sed -i 's/DB_CONNECTION.\+/DB_CONNECTION=mysql/' .env
sed -i 's/DB_HOST.\+/DB_HOST=mysql/' .env
sed -i 's/DB_PORT.\+/DB_PORT=3306/' .env
sed -i 's|DB_DATABASE.\+|echo "DB_DATABASE="$(cat /secrets/mysql_db)|e' .env
sed -i 's|DB_USERNAME.\+|echo "DB_USERNAME="$(cat /secrets/mysql_user)|e' .env
sed -i 's|DB_PASSWORD.\+|echo "DB_PASSWORD="$(cat /secrets/mysql_password)|e' .env
