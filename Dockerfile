FROM debian:wheezy

RUN apt-get update && apt-get install -y apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN a2enmod proxy; a2enmod proxy_http; a2enmod ssl

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

COPY 000-default /etc/apache2/sites-enabled/000-default
COPY ports.conf /etc/apache2/ports.conf
COPY htpasswd /etc/apache2/.htpasswd

COPY certificate.crt /etc/ssl/certificate.crt
COPY private.key /etc/ssl/private.key
COPY ca_bundle.crt /etc/ssl/ca_bundle.crt
#CMD "/bin/bash"
#CMD "/usr/sbin/apachectl start"
#CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]

#CMD [“-D”, “FOREGROUND”]
#ENTRYPOINT [“apachectl”]
EXPOSE 8080
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

