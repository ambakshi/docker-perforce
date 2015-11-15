FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4D_VERSION 2015.2
ENV REFRESHED_AT 2015-11-15

RUN yum install -y helix-p4d-$P4D_VERSION helix-p4dctl
RUN yum install -y tar gzip

RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.16.0.0/s6-overlay-amd64.tar.gz | tar zxf - -C /
RUN curl -sSL https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/bin/gosu && chmod +x /usr/bin/gosu

EXPOSE 1666 8080
ENV NAME=p4depot P4CONFIG=.p4config P4ROOT=/data/p4depot P4PORT=ssl:1666 P4USER=p4admin
VOLUME /data

ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
