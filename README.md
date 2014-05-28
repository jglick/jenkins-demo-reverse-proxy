The Jenkins wiki page [Running Jenkins behind Apache](https://wiki.jenkins-ci.org/display/JENKINS/Running+Jenkins+behind+Apache) explains how to set up an Apache reverse proxy.
This container serves as a demonstration but also lets you interactively test that setup, for example to verify that a plugin you are developing works correctly behind a proxy.
(For example, whether `Jenkins.getInstance().getRootUrl()` is being used properly.)

Usage:

```
cd jenkinsci/my-plugin
mvn hpi:run &
docker run -p 80:80 jglick/jenkins-demo-reverse-proxy &
```

Then browse http://localhost/jenkins/ to see the result.
(You ought to [configure Jenkins](http://localhost/jenkins/configure) and specify its URL explicitly; otherwise it guesses at its root URL from each HTTP request.)

The assumption is that the host is visible from the container as `172.17.42.1`.
If this is not true in your case, you must override the `HOST` environment variable to specify it:

```
docker run -p 80:80 -e HOST=<YOUR-HOST-IP-ADDRESS> jglick/jenkins-demo-reverse-proxy &
```
