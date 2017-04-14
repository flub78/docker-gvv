# SQL script to setup the GVV database

# Set a password for root
set password for 'root'@'localhost' = PASSWORD('$MYSQL_ROOT_PASSWORD');

# create GVV database
create database gvv2;
use gvv2;

create user $MYSQL_USER_NAME@'%' identified by '$MYSQL_USER_PASSWORD';
grant all on gvv2.* to $MYSQL_USER_NAME@'%';
