########################################################################
# systemd baseos
########################################################################
ARG BASEOS
ARG P4D_VERSION=2021.1
ARG P4_VERSION=21.1
ARG SWARM_VERSION=2021.1
FROM $BASEOS AS baseos
ARG BASEOS
ARG P4D_VERSION
ARG P4_VERSION
ARG SWARM_VERSION

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
        netcat-openbsd \
        patch \
        diffutils \
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
########################################################################
# perforce-swarm from baseos
########################################################################
FROM baseos as perforce-swarm
ARG BASEOS
ARG P4D_VERSION
ARG SWARM_VERSION

RUN apt-get update -yqq && \
    export DEBIAN_FRONTEND=noninteractive RUNLEVEL=1 && \
    apt-get install -yq --no-install-recommends \
        gettext-base \
        php-yaml \
        sendmail && \
    apt-get clean all && rm -rf /var/lib/apt/lists/*


RUN apt-get update -q && \
    export DEBIAN_FRONTEND=noninteractive TZ=America/Los_Angeles RUNLEVEL=1 && \
    apt-get install -yq --no-install-recommends \
        helix-cli \
        helix-swarm=${SWARM_VERSION}\* \
        helix-swarm-optional=${SWARM_VERSION}\* \
        helix-swarm-triggers=${SWARM_VERSION}\* && \
    apt-get clean all && rm -rf /var/cache/apt/lists/*

#### SYSTEMD
ADD ["perforce-swarm/systemd-units.txt","/root/"]
RUN sed -r '\@^(\+|#)@d; s@^-@@'  < /root/systemd-units.txt | xargs -r -I{} rm -fv -- {}
#### STANDARD SYSTEMD

ADD ["perforce-swarm/helix-swarm.timer","perforce-swarm/helix-swarm.service","/etc/systemd/system/"]

RUN ln -sfnv /etc/systemd/system/helix-swarm.timer /etc/systemd/system/multi-user.target.wants/ && \
    echo "Fixing warnings from original packages ..." && \
    chmod 0644 /etc/systemd/system/redis-server-swarm.service && \
    sed -r -i 's,SyslogIndentifier,SyslogIdentifier,' /etc/systemd/system/redis-server-swarm.service

#ADD ["noebpf.conf","/etc/systemd/system/systemd-journald.service.d/"]
#ADD ["redis-server.service","/etc/systemd/system/"]

ENV P4PORT=perforce:1666
ENV SWARM_USER=swarm
ENV MXHOST=localhost
EXPOSE 80 443
ADD ["perforce-swarm/0001-configure-swarm-allow-empty-pass.diff","/opt/perforce/swarm/sbin/"]
RUN cd /opt/perforce/swarm/sbin/ && patch -p1 < 0001-configure-swarm-allow-empty-pass.diff

ADD ["perforce-swarm/run.sh","/"]
ENTRYPOINT ["/run.sh"]
########################################################################
# perforce-proxy from baseos
########################################################################

ARG P4_VERSION
FROM $BASEOS AS peforce-proxy
ARG BASEOS
ARG P4D_VERSION
ARG SWARM_VERSION
ARG P4_VERSION
ENV P4_VERSION=$P4_VERSION

ADD ["http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4","http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4p","/usr/bin/"]
RUN chmod +x /usr/bin/p4p /usr/bin/p4

ENV P4TARGET=perforce:1666
ENV P4PORT=1666
ENV P4PCACHE=/cache

VOLUME ["$P4PCACHE"]

EXPOSE 1666

CMD ["/usr/bin/p4p"]

########################################################################
# perforce-server from baseos
########################################################################

FROM baseos as perforce-server
ARG BASEOS
ARG P4D_VERSION
ARG SWARM_VERSION

LABEL MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends helix-p4d=${P4D_VERSION}\* helix-cli && \
    apt-get clean all && rm -rf /var/lib/apt/lists/*


RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends perl-modules libjson-perl libjson-xs-perl libhttp-tiny-perl && \
    apt-get clean all && rm -rf /var/lib/apt/lists/*

ADD ["perforce-server/systemd-units.txt","/root/"]
RUN sed -r '\@^(\+|#)@d; s@^-@@'  < /root/systemd-units.txt | xargs -r -I{} rm -fv -- {}


ADD ["perforce-server/p4-users.txt","perforce-server/p4-groups.txt","perforce-server/p4-protect.txt","/root/"]
ADD ["perforce-server/setup-perforce.sh","/usr/local/bin/"]
ADD ["perforce-server/perforce.service","/etc/systemd/system/"]
ADD ["perforce-server/perforce.default","/etc/default/perforce"]
ADD ["perforce-server/run.sh", "/root/"]

ENV NAME=p4depot
ENV DATAVOLUME=/data

ARG P4ROOT=$DATAVOLUME
ENV P4ROOT=$P4ROOT
ENV P4CONFIG=.p4config
ENV P4PORT=1666
ENV P4USER=p4admin
ENV CASE_INSENSITIVE=
ENV P4EXTRAFLAGS=${CASE_INSENSITIVE:+-C1}

RUN mkdir -p /etc/systemd/system/multi-user.target.wants && \
    ln -svfn /etc/systemd/system/perforce.service /etc/systemd/system/multi-user.target.wants/

EXPOSE $P4PORT
VOLUME ["$DATAVOLUME"]

ADD ["perforce-server/run.sh","/"]

ENTRYPOINT ["/run.sh"]
CMD ["/lib/systemd/systemd","--system","--log-target=journal"]

########################################################################
# perforce-sampledepot from perforce-server
########################################################################
FROM perforce-server as perforce-sampledepot
ARG BASEOS
ARG P4D_VERSION
ARG SWARM_VERSION

ENV DATAVOLUME=/data
ENV P4ROOT=$DATAVOLUME/PerforceSample
RUN mkdir -p $P4ROOT && \
    curl -fL ftp://ftp.perforce.com/perforce/tools/sampledepot.tar.gz -o /root/sampledepot.tar.gz && \
    tar zxf /root/sampledepot.tar.gz --strip=1 -C $P4ROOT && \
    p4d -r $P4ROOT -jr $P4ROOT/checkpoint && \
    p4d -r $P4ROOT -xu && \
    chown -R perforce:perforce $P4ROOT && \
    chmod 0700 $P4ROOT

RUN echo "P4ROOT=$P4ROOT" >> /etc/default/perforce

ADD ["perforce-sampledepot/run.sh","/"]

VOLUME ["$DATAVOLUME"]

