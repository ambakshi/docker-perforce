FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4WEB_VERSION 12.1
RUN yum install -y curl ca-certificates tar gzip
RUN useradd -m -s /bin/bash perforce
RUN curl -o /usr/bin/p4web -sSL "https://swarm.workshop.perforce.com/projects/perforce-software-p4web/download/main/bin/r${P4WEB_VERSION}/bin.linux26x86_64/p4web" && chmod +x /usr/bin/p4web
RUN curl -sSL "https://github.com/just-containers/s6-overlay/releases/download/v1.14.0.4/s6-overlay-amd64.tar.gz" | tar zxf - -C /
# RUN curl -o /usr/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.4/gosu-amd64" && chmod +x /usr/bin/gosu
ENV P4PORT=perforce:1666 P4CLIENT=myclient P4USER=perforce P4PASSWD=pass P4HOST=host
EXPOSE 8080
ENTRYPOINT ["/init"]
CMD ["/usr/bin/p4web","-b","-U","perforce","-w","8080"]

