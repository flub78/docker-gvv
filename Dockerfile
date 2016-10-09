FROM flub78/lamp-svn:latest
MAINTAINER Frédéric Peignot frederic.peignot@free.fr

ENV MAINTAINER "Frédéric Peignot"

RUN	cd /var/www/html && \
	svn export http://subversion.developpez.com/projets/gvv/trunk/gvv

ADD create_db.sql /tmp/
ADD init_db.sh /tmp/
RUN /tmp/init_db.sh

EXPOSE 80
EXPOSE 22

RUN useradd -ms /bin/bash frederic

ADD gvv.conf /etc/apache2/sites-enabled/000-default.conf
ADD config.php /var/www/html/gvv/application/config/config.php
	
ENTRYPOINT service mysql start && \
	service ssh restart  && \
	/usr/sbin/apache2ctl -D FOREGROUND
