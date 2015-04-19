FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4D_VERSION 2015.1

RUN yum install -y perforce-server
RUN curl -fsSL -O https://swarm.workshop.perforce.com/projects/perforce-software-p4web/download/main/bin/r12.1/bin.linux26x86_64/p4web && chmod +x p4web && mv p4web /usr/local/bin/

EXPOSE 1666 8080
ENV NAME=p4depot P4CONFIG=.p4config P4ROOT=/data/p4depot P4PORT=ssl:1666 P4USER=p4admin
VOLUME /data

ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
