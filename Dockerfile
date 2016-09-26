FROM flub78/lamp-svn:latest
MAINTAINER Frédéric Peignot frederic.peignot@free.fr

RUN	cd /var/www/html && \
	svn co http://subversion.developpez.com/projets/gvv/trunk/gvv

ADD create_db.sql /tmp/
ADD init_db.sh /tmp/
RUN /tmp/init_db.sh
