FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y helix-p4d helix-cli

EXPOSE 1666
ENV NAME p4depot
ENV P4CONFIG .p4config
ENV DATAVOLUME /data
ENV P4PORT 1666
ENV P4USER p4admin
VOLUME ["$DATAVOLUME"]

ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./setup-perforce.sh /usr/local/bin/
ADD ./run.sh  /

CMD ["/run.sh"]
