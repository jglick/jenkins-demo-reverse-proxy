The Jenkins wiki page [Running Jenkins behind Apache](https://wiki.jenkins-ci.org/display/JENKINS/Running+Jenkins+behind+Apache) explains how to set up an Apache reverse proxy.
This container serves as a demonstration but also lets you interactively test that setup, for example to verify that a plugin you are developing works correctly behind a proxy.
(For example, whether `Jenkins.getInstance().getRootUrl()` is being used properly.)

Usage:

```
cd jenkinsci/my-plugin
mvn hpi:run &
docker run --rm -p 127.0.0.1:80:80 --network=host jglick/jenkins-demo-reverse-proxy
```

Then browse http://localhost/jenkins/ to see the result.
(You ought to [configure Jenkins](http://localhost/jenkins/configure) and specify its URL explicitly; otherwise it guesses at its root URL from each HTTP request.)

If you want to test HTTPS proxying (for example to verify that insecure content is not getting served from a secure page),
proxy port 443 instead
and browse to https://localhost/jenkins/ to see the result. This uses a self-signed certificate, so you will need to tell your browser to accept it. Again make sure you have configured the Jenkins root URL explicitly.
