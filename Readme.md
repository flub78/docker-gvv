# flub78/docker-gvv

Defines a docker environment with a live GVV application.

It is made of
* a MySql container with a mount volume for persistency
* an Apache container serving a mount volume containing GVV 

For development
* a phpmyadmin container to manage the database

All examples are given with the default passwords, of course you are really encouraged to rebuild the containers with your own passwords. You just need to reset the values defined in the setenv.sh file in your environment before to execute bin/build.sh

Check and adapt the setenv.sh script to fit to your local environment.
 
## Usage

### To start the containers

	source setenv.sh
    docker-compose up -d
 
### Build
    
	All containers are publicly available on dockerhub. The ones which have been modified
	are automatically built from github each time that the git repository is modified.
	
### Networking

	The containers publish one or several ports to the docker engine host. Once the containers started, the docker engine host can receive queries on several ports which will be redirected
	to the containers. All ports are define by the environment variables in the setenv.sh file.
	
	If the docker engine server is referenced by a DNS, the domain can be used to make the request.
	
	For example if flub.fr is the domain
	
	To reset GVV
	http://flub78.fr:90/install/reset.php
	
	To install GVV
	http://flub78.fr:90/install/
	
	To use GVV
	http://flub78.fr:90/
	(user = testadmin, password = password)
	
	To access phpmyadmin
	http://flub78.fr:7090/


## Database

### Local access
From the container

    mysql -u root -h localhost -pdb_password

    show databases;
    select host, user, password from mysql.user;

gvv_user has been created

     mysql -u gvv_user -h localhost -puser_password


### Remote access

The database of the GVV container can be access remotely

    mysql -u gvv_user -h gvv.fr -puser_password

phpmyadmin is available in the gvv1_myadmin_1 container using the same user and password


## Utilities

* bin/ip.sh a script to find the IP address of a container

## To do

* create an ansible script to deploy
* Use apache virtual hosts to access the different services through subdomains
* enable phpunit tests
* Support creation of an environment for a specific version
* Support multiple deployment (make the domain configurable)


## Troubleshooting

Log in the container

      docker exec -ti gvv1_gvv_1 /bin/bash

Check that apache is running:
```
docker exec -ti gvv1_gvv_1 /bin/bash
root@gvv:/var/www/html# service apache2 status
[ ok ] apache2 is running.

```
Check apache configuration
```
root@gvv:/var/www/html# apache2 -S
[Sat Apr 15 18:51:29.842618 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_LOCK_DIR} is not defined
[Sat Apr 15 18:51:29.843019 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_PID_FILE} is not defined
[Sat Apr 15 18:51:29.843093 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_RUN_USER} is not defined
[Sat Apr 15 18:51:29.843113 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_RUN_GROUP} is not defined
[Sat Apr 15 18:51:29.843159 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_LOG_DIR} is not defined
[Sat Apr 15 18:51:30.253481 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_LOG_DIR} is not defined
[Sat Apr 15 18:51:30.254596 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_LOG_DIR} is not defined
[Sat Apr 15 18:51:30.254682 2017] [core:warn] [pid 589] AH00111: Config variable ${APACHE_LOG_DIR} is not defined
AH00526: Syntax error on line 74 of /etc/apache2/apache2.conf:
Invalid Mutex directory in argument file:${APACHE_LOCK_DIR}
r

```
Check virtual hosts
```
root@gvv:/var/www/html# apache2ctl -S
VirtualHost configuration:
*:80                   is a NameVirtualHost
         default server localhost (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost localhost (/etc/apache2/sites-enabled/000-default.conf:1)
         port 80 namevhost gvv.fr (/etc/apache2/sites-enabled/gvv.conf:1)
                 alias www.gvv.fr
ServerRoot: "/etc/apache2"
Main DocumentRoot: "/var/www/html"
Main ErrorLog: "/var/log/apache2/error.log"
Mutex default: dir="/var/lock/apache2" mechanism=fcntl 
Mutex mpm-accept: using_defaults
Mutex watchdog-callback: using_defaults
Mutex rewrite-map: using_defaults
PidFile: "/var/run/apache2/apache2.pid"
Define: DUMP_VHOSTS
Define: DUMP_RUN_CFG
User: name="www-data" id=33
Group: name="www-data" id=33

```
Check network configuration of the container
```
root@gvv:/var/www/html# ifconfig
eth0      Link encap:Ethernet  HWaddr 02:42:ac:15:00:02  
          inet addr:172.21.0.2  Bcast:0.0.0.0  Mask:255.255.0.0
          inet6 addr: fe80::42:acff:fe15:2/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:166 errors:0 dropped:0 overruns:0 frame:0
          TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:26499 (25.8 KiB)  TX bytes:1026 (1.0 KiB)

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

Check logs from the docker engine
```
frederic@flub78 ~ $ docker logs -f gvv1_gvv_1
Starting MySQL database server: mysqld ..
Checking for tables which need an upgrade, are corrupt or were 
not closed cleanly..
[Sat Apr 15 17:24:00.346429 2017] [mpm_prefork:notice] [pid 432] AH00163: Apache/2.4.10 (Debian) PHP/5.6.30 configured -- resuming normal operations
[Sat Apr 15 17:24:00.346534 2017] [core:notice] [pid 432] AH00094: Command line: 'apache2 -D FOREGROUND'

```

Check apache logs
```
tail -f /var/log/apache2/error.log
```

Check access to the apache server from inside the container

```
cd tmp
wget http://localhost
less index.html
```
The index.html contains the output of index.php.
It implies that the apache server works fine.


Check that the domain is resolved and the container answer to ping
```
frederic@flub78 ~ $ ping gvv.fr
PING gvv.fr (172.21.0.2) 56(84) bytes of data.
64 bytes from gvv.fr (172.21.0.2): icmp_seq=1 ttl=64 time=0.169 ms
64 bytes from gvv.fr (172.21.0.2): icmp_seq=2 ttl=64 time=0.164 ms
64 bytes from gvv.fr (172.21.0.2): icmp_seq=3 ttl=64 time=0.142 ms
64 bytes from gvv.fr (172.21.0.2): icmp_seq=4 ttl=64 time=0.154 ms

```



