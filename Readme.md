# flub78/docker-gvv

Defines a docker container with a live GVV application.

For production
* A PHP enabled WEB server plus the GVV sources container
* a MySql container

For development
* a phpmyadmin container
* a jenkins container

## Usage

docker-compose -d -p gvv up

docker exec -ti dockergvv_gvv_1 /bin/bash
 
1. to build locally
bin/build.sh

1. Make sure that gvv.fr resolves to the container

1. the following URL are available
http://gvv.fr/install
http://gvv.fr		
(user = testadmin, password = password)

http://172.19.0.3/gvv/install
or 
http://gvv.fr/install/

## Database

Currently, there is no password on the local database
mysql -u root -h localhost

gvv_user has been created
mysql -u gvv_user -h localhost -plfoyfgbj

mysql> set password for 'root'@'localhost' = PASSWORD('toto');

mysql -h 172.24.0.2 -u root -ptoto









