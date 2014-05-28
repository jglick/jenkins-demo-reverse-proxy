# Usage:
# cd jenkinsci/my-plugin
# mvn hpi:run &
# docker run -p 80:80 -e HOST=<YOUR-HOST-IP-ADDRESS> jglick/jenkins-demo-reverse-proxy &
# browse http://localhost/jenkins/

FROM gvangool/docker-apache2
MAINTAINER jglick@cloudbees.com

# Best to specify this explicitly:
ENV HOST 172.17.42.1

# https://wiki.jenkins-ci.org/display/JENKINS/Running+Jenkins+behind+Apache
RUN a2enmod proxy
RUN a2enmod proxy_http
ADD site-default.conf /etc/apache2/sites-available/default
