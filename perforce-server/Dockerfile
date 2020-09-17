ARG P4D_VERSION
FROM ambakshi/perforce-base:${P4D_VERSION}
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ARG P4D_VERSION

RUN yum install -y helix-p4d-${P4D_VERSION} helix-cli-${P4D_VERSION} \
    && yum clean all --enablerepo='*' \
    && rm -rf /var/cache/yum/*

ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./setup-perforce.sh /usr/local/bin/
ADD ./run.sh /

ENV NAME p4depot
ENV P4CONFIG .p4config
ENV DATAVOLUME /data
ENV P4PORT 1666
ENV P4USER p4admin
EXPOSE $P4PORT
VOLUME ["$DATAVOLUME"]

ENTRYPOINT ["/run.sh"]
