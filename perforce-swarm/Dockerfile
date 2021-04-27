FROM ubuntu@sha256:3c9c713e0979e9bd6061ed52ac1e9e1f246c9495aa063619d9d695fb8039aa1f AS baseos
LABEL MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN printf '#!/bin/sh\nexit 101\n' | tee /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d && \
    export DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 && \
    apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
        curl \
        ca-certificates \
        tar \
        gzip \
        gnupg2 \
        locales \
        dbus \
        apt-utils \
        vim-tiny \
        systemd && \
    export LANG=en_US.UTF-8 LANGUAGE="en_US:en" && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    apt-get clean all && rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://package.perforce.com/perforce.pubkey -o /tmp/p4.pub && \
    apt-key add /tmp/p4.pub && \
    . /etc/os-release && \
    echo "deb http://package.perforce.com/apt/ubuntu ${VERSION_CODENAME} release" > /etc/apt/sources.list.d/perforce.list && \
    mkdir -p /etc/systemd/system/systemd-journald.service.d && \
    mkdir -p /etc/systemd/system/multi-user.target.wants/ && \
    systemctl set-default multi-user.target && \
    : > /etc/machine-id

ENV LANG=en_US.UTF-8 LANGUAGE=en_US:en
ENV container=docker
ENV DEBIAN_FRONTEND=noninteractive

STOPSIGNAL SIGRTMIN+3

CMD ["/lib/systemd/systemd","--system","--log-target=journal"]
######## perforce server
FROM baseos as perforce-server
ARG P4D_VERSION=2021

LABEL MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN apt-get update -q && \
    apt-get install -yq --no-install-recommends helix-p4d-${P4D_VERSION}\* helix-cli-${P4D_VERSION}\* && \
    apt-get clean all && rm -rf /var/lib/apt/lists/*


ADD ["systemd-units.txt","/root"]
RUN sed -r '\@^#@d' < /root/systemd-units.txt | xargs -r rm -fv


ADD ["p4-users.txt","p4-groups.txt","p4-protect.txt","/root/"]
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

RUN mkdir -p /etc/systemd/system/multi-user.target.wants && \
    ln -svfn /etc/systemd/system/perforce.service /etc/systemd/system/multi-user.target.wants/

EXPOSE $P4PORT
VOLUME ["$DATAVOLUME"]


CMD ["/lib/systemd/systemd","--system","--log-target=journal"]

#########
FROM baseos as perforce-swarm

RUN apt-get update -yqq && \
    export DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 && \
    apt-get install -yq --no-install-recommends \
        gettext-base \
        php-yaml \
        sendmail && \
    apt-get clean all && rm -rf /var/lib/apt/lists/*

ARG SWARM_VERSION=2021.1
ENV SWARM_VERSION=$SWARM_VERSION

RUN apt-get update -q && \
    export DEBIAN_FRONTEND=noninteractive TZ=America/Los_Angeles RUNLEVEL=1 && \
    apt-get install -yq --no-install-recommends \
        helix-cli \
        helix-swarm=${SWARM_VERSION}\* \
        helix-swarm-optional=${SWARM_VERSION}\* \
        helix-swarm-triggers=${SWARM_VERSION}\* && \
    apt-get clean all && rm -rf /var/cache/apt/lists/*

#### SYSTEMD
ADD ["systemd-units.txt","/root/"]
RUN sed -r '\@^(\+|#)@d; s@^-@@'  < /root/systemd-units.txt | xargs -r rm -fv --
#### STANDARD SYSTEMD

ADD ["helix-swarm.timer","helix-swarm.service","/etc/systemd/system/"]

RUN ln -sfnv /etc/systemd/system/helix-swarm.timer /etc/systemd/system/multi-user.target.wants/ && \
    echo "Fixing warnings from original packages ..." && \
    chmod 0644 /etc/systemd/system/redis-server-swarm.service && \
    sed -r -i 's,SyslogIndentifier,SyslogIdentifier,' /etc/systemd/system/redis-server-swarm.service

#ADD ["noebpf.conf","/etc/systemd/system/systemd-journald.service.d/"]
#ADD ["redis-server.service","/etc/systemd/system/"]

ENV P4PORT=perforce:1666
ENV P4USER=swarm
ENV P4PASSWD=swarm
ENV MXHOST=localhost
EXPOSE 80 443

