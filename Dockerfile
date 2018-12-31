FROM ubuntu:18.04

VOLUME ["/opt/arch"]
WORKDIR /opt/arch

RUN apt-get update && \
	apt-get install -y nginx git fcgiwrap && \
	apt-get clean

COPY nginx/default /etc/nginx/sites-enabled/default

EXPOSE 80
CMD 	mkdir -p /opt/arch/data && \
	spawn-fcgi -s /var/run/fcgiwrap.socket /usr/sbin/fcgiwrap && \
	chown www-data.www-data /var/run/fcgiwrap.socket && \
	nginx -g 'daemon off;'
