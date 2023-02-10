#! /bin/bash

sed -i 's|APP_URL.\+|APP_URL=http://127.0.0.1|' /app/.env
sed -i 's/APP_PORT.\+/#APP_PORT/' /app/.env
sed -i 's/DB_CONNECTION.\+/DB_CONNECTION=mysql/' /app/.env
sed -i 's/DB_HOST.\+/DB_HOST=localhost/' /app/.env
sed -i 's/DB_PORT.\+/DB_PORT=3306/' /app/.env
sed -i 's|DB_DATABASE.\+|echo "DB_DATABASE="$(cat /secrets/mysql_db)|e' /app/.env
sed -i 's|DB_USERNAME.\+|echo "DB_USERNAME="$(cat /secrets/mysql_user)|e' /app/.env
sed -i 's|DB_PASSWORD.\+|echo "DB_PASSWORD="$(cat /secrets/mysql_password)|e' /app/.env
