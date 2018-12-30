FROM ubuntu:18.04

VOLUME ["/opt/arch"]
WORKDIR /opt/arch

RUN apt-get update && \
	apt-get install -y nginx git fcgiwrap && \
	apt-get clean && \
	mkdir -p /var/run/nginx && \
	chown -R www-data.www-data /var/run/nginx && \
	chmod g+s /var/run/nginx

COPY nginx/default /etc/nginx/sites-enabled/default

EXPOSE 80
CMD 	mkdir -p /opt/arch/data && \
	spawn-fcgi -s /var/run/nginx/fcgiwrap.socket /usr/sbin/fcgiwrap && \
	chown www-data.www-data /var/run/nginx/fcgiwrap.socket && \
	nginx -g 'daemon off;'
