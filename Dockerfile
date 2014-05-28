FROM gvangool/docker-apache2
MAINTAINER jglick@cloudbees.com

# Seems to be the default value:
ENV HOST 172.17.42.1

# https://wiki.jenkins-ci.org/display/JENKINS/Running+Jenkins+behind+Apache
RUN a2enmod proxy
RUN a2enmod proxy_http
ADD site-default.conf /etc/apache2/sites-available/default
