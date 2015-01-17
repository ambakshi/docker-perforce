FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y perforce-server
RUN curl -fsSL http://www.perforce.com/downloads/perforce/r12.1/bin.linux26x86_64/p4web > /usr/bin/p4web && chmod +x /usr/bin/p4web

ENV P4ROOT /data
ENV P4PORT ssl:1666
ENV P4USER p4admin

VOLUME /data

EXPOSE 1666 8080

ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
