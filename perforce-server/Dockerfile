ARG P4D_VERSION
FROM ambakshi/perforce-base:${P4D_VERSION}
ARG P4D_VERSION

LABEL MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum clean all && \
    yum install -y helix-p4d-${P4D_VERSION} helix-cli-${P4D_VERSION} \
    && yum clean all --enablerepo='*' \
    && rm -rf /var/cache/yum/*

ADD ["systemd-units.txt","p4-users.txt","p4-groups.txt","p4-protect.txt","/root/"]
ADD ["setup-perforce.sh","/usr/local/bin/"]
ADD ["perforce.service","/etc/systemd/system/"]
ADD ["perforce.default","/etc/default/perforce"]
ADD ["run.sh", "/root/"]

ENV NAME=p4depot
ENV DATAVOLUME=/data

ARG P4ROOT=$DATAVOLUME
ENV P4ROOT=$P4ROOT
ENV P4CONFIG=.p4config
ENV P4PORT=1666
ENV P4USER=p4admin

RUN sed -r '\@^(\+|#)@d; s@^-@@'  < /root/systemd-units.txt | xargs -r -I{} rm -fv -- {} && \
        mkdir -p /etc/systemd/system/multi-user.target.wants && \
        : > /etc/machine-id && \
        mkdir -p /etc/systemd/system/multi-user.target.wants/ && \
        ln -svfn /etc/systemd/system/perforce.service /etc/systemd/system/multi-user.target.wants/

EXPOSE $P4PORT
VOLUME ["$DATAVOLUME"]


CMD ["/lib/systemd/systemd","--system","--log-target=journal"]
