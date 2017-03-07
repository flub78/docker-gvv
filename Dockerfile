# Dockerfile to build a gvv container

FROM php:5.6-apache
MAINTAINER Frédéric Peignot frederic.peignot@free.fr

ENV MAINTAINER "Frédéric Peignot"

# install packages
RUN apt-get update
RUN apt-get install -y subversion \
  vim \
  wget \
  php5-curl php5-dev php5-gd \
  libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev \
  phpunit

# Install mysql without password  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
  mysql-client

RUN	cd /var/www/html && \
  svn export http://subversion.developpez.com/projets/gvv/trunk/gvv

# Crete the database
ADD create_db.sql /tmp/
ADD init_db.sh /tmp/
RUN /tmp/init_db.sh

# Install PDO MySQL driver
# See https://github.com/docker-library/php/issues/62
RUN docker-php-ext-install pdo mysql
RUN docker-php-ext-install pdo mysqli
RUN docker-php-ext-install -j$(nproc) iconv mcrypt \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd

# Configure apache
ADD servername.conf /etc/apache2/conf-available
RUN a2enconf servername
RUN a2enmod rewrite
ADD php.ini-development /usr/local/etc/php/php.ini 

EXPOSE 80
EXPOSE 22

RUN useradd -ms /bin/bash frederic

ADD sites-available/gvv.conf /etc/apache2/sites-available

ADD config.php /var/www/html/gvv/application/config/config.php
ADD html/index.html /var/www/html
ADD html/index.php /var/www/html
RUN a2ensite gvv
	
ENTRYPOINT service mysql start && \
	apache2-foreground
#	/usr/sbin/apache2ctl -D FOREGROUNDS


