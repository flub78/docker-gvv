# flub78/docker-gvv

Defines a docker container with a live GVV application.

For production
* A PHP enabled WEB server plus the GVV sources container
* a MySql container (optional, Mysql is also deployed in the GVV container to make it self-sufficient in production)

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


## Database

### Local access
Currently, there is no password on the local database
mysql -u root -h localhost

	show databases;
	select host, user, password from mysql.user;

gvv_user has been created
mysql -u gvv_user -h localhost -plfoyfgbj


### Remote access
phpmyadmin is available at http://172.19.0.4/

mysql -u gvv_user -h 172.19.0.3 -plfoyfgbj

## Utilities

* bin/build.sh a shell script to rebuild the container
* bin/ip.sh a script to find the IP address oa a container
* bin/login.sh a script to start a bash in the gvv container

## To do

* connect phpmyadmin to the database
* enable phpunit tests
* Support creation of an environment for a specific version
* Support multiple deployment (make the domain configurable)








