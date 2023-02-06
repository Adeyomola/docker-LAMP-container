FROM mysql
EXPOSE 3306
HEALTHCHECK --retries=3 --timeout=60s CMD mysqladmin ping -h localhost
ENV MYSQL_ROOT_PASSWORD_FILE=/secrets/mysql_root MYSQL_DATABASE_FILE=/secrets/mysql_db \
MYSQL_USER_FILE=/secrets/mysql_user MYSQL_PASSWORD_FILE=/secrets/mysql_password
