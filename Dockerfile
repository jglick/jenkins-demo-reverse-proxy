FROM ubuntu:14.04
MAINTAINER jglick@cloudbees.com

# adapted from gvangool/docker-apache2
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
#RUN echo "deb http://archive.ubuntu.com/ubuntu trusty universe" >> /etc/apt/sources.list
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y apache2 curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
EXPOSE 80 443

# https://wiki.jenkins-ci.org/display/JENKINS/Running+Jenkins+behind+Apache
RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod ssl
RUN a2enmod headers
RUN a2enmod alias
RUN a2ensite default-ssl
ADD generic.conf /etc/apache2/generic
ADD site-default.conf /etc/apache2/sites-available/000-default.conf
ADD site-ssl.conf /etc/apache2/sites-available/default-ssl.conf
ADD empty.json /var/www/empty.json
CMD ["apache2ctl", "-X"]
