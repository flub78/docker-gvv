create database gvv2;
use gvv2;

create user gvv_user@localhost identified by 'lfoyfgbj';
grant all on gvv2.* to gvv_user@localhost;

