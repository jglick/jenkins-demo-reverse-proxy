The Jenkins wiki page [Running Jenkins behind Apache](https://wiki.jenkins-ci.org/display/JENKINS/Running+Jenkins+behind+Apache) explains how to set up an Apache reverse proxy.
This container serves as a demonstration but also lets you interactively test that setup, for example to verify that a plugin you are developing works correctly behind a proxy.
(For example, whether `Jenkins.getInstance().getRootUrl()` is being used properly.)

Usage:

```
cd jenkinsci/my-plugin
mvn hpi:run &
docker run --rm -p 80:80 jglick/jenkins-demo-reverse-proxy
```

Then browse http://localhost/jenkins/ to see the result.
(You ought to [configure Jenkins](http://localhost/jenkins/configure) and specify its URL explicitly; otherwise it guesses at its root URL from each HTTP request.)

The assumption is that the host is visible from the container as `172.17.0.1`.
If this is not true in your case, you must override the `HOST` environment variable to specify it:

```
docker run -p 80:80 -e HOST=<YOUR-HOST-IP-ADDRESS> jglick/jenkins-demo-reverse-proxy &
```

Note that your Jenkins launch method must _not_ pass `--httpListenAddress=127.0.0.1` for this to work.
Currently `mvn hpi:run` does so.
For reasons unknown, `-e HOST=127.0.0.1 --network=host` does not suffice to work around this
(even though `curl -I http://127.0.0.1:8080/jenkins/` works inside the container).

If you want to test HTTPS proxying (for example to verify that insecure content is not getting served from a secure page), use

```
docker run -p 443:443 jglick/jenkins-demo-reverse-proxy &
```

and browse to https://localhost/jenkins/ to see the result. This uses a self-signed certificate, so you will need to tell your browser to accept it. Again make sure you have configured the Jenkins root URL explicitly.
