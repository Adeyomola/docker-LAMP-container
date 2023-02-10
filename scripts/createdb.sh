#!/bin/bash

mysql -u root -p= -e 'CREATE DATABASE altschool'
mysql -u root -p= -e "CREATE USER adeyomola IDENTIFIED BY '$(cat /secrets/mysql_password)'"
mysql -u root -p= -e "GRANT ALL ON altschool.* TO adeyomola@localhost IDENTIFIED BY '$(cat /secrets/mysql_password)'"
mysql -u root -p= -e "FLUSH PRIVILEGES"
mysql -u root -p= -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /secrets/mysql_root)'"

