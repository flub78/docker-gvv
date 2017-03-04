# flub78/docker-gvv

defines a docker container with a live GVV application.

## Usage

docker-compose up -d

docker exec -ti dockergvv_gvv_1 /bin/bash
 
1. to build locally
bin/build.sh

1. Make sure that gvv.fr resolves to the container

1. the following URL are available
http://gvv.fr/install
http://gvv.fr		
(user = testadmin, password = password)

## Database
mysql> set password for 'root'@'localhost' = PASSWORD('titi');







