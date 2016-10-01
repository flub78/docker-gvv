FROM flub78/lamp-svn:latest
MAINTAINER Frédéric Peignot frederic.peignot@free.fr

RUN	cd /var/www/html && \
	svn export http://subversion.developpez.com/projets/gvv/trunk/gvv

ADD create_db.sql /tmp/
ADD init_db.sh /tmp/
RUN /tmp/init_db.sh

EXPOSE 80
EXPOSE 22

ENTRYPOINT service mysql start && \
	service apache2 start && \
	service ssh restart && \
	tail -f /var/log/apache2/access.log
