# SQL script to setup the GVV database

# Set a password for root
# set password for 'root'@'localhost' = PASSWORD('mysql_password');

# create GVV database
create database gvv2;
use gvv2;

create user gvv_user@'%' identified by 'lfoyfgbj';
grant all on gvv2.* to gvv_user@'%';

