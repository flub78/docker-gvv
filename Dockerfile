FROM flub78/lamp-svn:latest
MAINTAINER Frédéric Peignot frederic.peignot@free.fr

RUN	cd /var/www/html && \
	svn export http://subversion.developpez.com/projets/gvv/trunk/gvv

ADD create_db.sql /tmp/
ADD init_db.sh /tmp/
RUN /tmp/init_db.sh

# Not used anymore to avoid the clear password
# RUN echo 'root:hello' | chpasswd

# More convenient to mount the authorized_keys from the host
# RUN mkdir -p /root/.ssh
# RUN chmod 700 /root/.ssh
# ADD id_rsa.pub /root/.ssh/authorized_keys
# RUN chmod 600 /root/.ssh/authorized_keys

EXPOSE 80
EXPOSE 22

RUN useradd -ms /bin/bash frederic

ENTRYPOINT service mysql start && \
	service apache2 start && \
	service ssh restart  && \
	tail -f /var/log/apache2/access.log
