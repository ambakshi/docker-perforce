FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4D_VERSION 2015.1
ENV REFRESHED_AT 2015-09-09

RUN yum install -y perforce-server

EXPOSE 1666 8080
ENV NAME=p4depot P4CONFIG=.p4config P4ROOT=/data/p4depot P4PORT=ssl:1666 P4USER=p4admin
VOLUME /data

ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
