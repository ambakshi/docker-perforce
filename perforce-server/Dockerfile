FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4D_VERSION 2014.2

RUN yum install -y perforce-server
RUN curl -fsSL -O http://www.perforce.com/downloads/perforce/r12.1/bin.linux26x86_64/p4web && chmod +x p4web && mv p4web /usr/local/bin/
RUN curl -fsSL -O http://cdist2.perforce.com/perforce/r15.1/bin.linux26x86_64/p4d && chmod +x p4d && mv p4d /usr/local/sbin/
RUN curl -fsSL -O http://cdist2.perforce.com/perforce/r15.1/bin.linux26x86_64/p4 && chmod +x p4 && mv p4 /usr/local/bin/ && ln -sfn /usr/local/bin/p4 /usr/bin/p4

EXPOSE 1666 8080
ENV NAME=p4depot P4CONFIG=.p4config P4ROOT=/data/p4depot P4PORT=ssl:1666 P4USER=p4admin
VOLUME /data

# NOTE: This template has been modified to run p4d 2015.1 from /usr/local/sbin
ADD ./p4d.template /etc/perforce/p4dctl.conf.d/p4d.template
ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
