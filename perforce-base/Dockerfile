FROM centos:centos6
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4D_VERSION 2016.1
ENV REFRESHED_AT 2016-05-14

RUN echo -ne '[perforce]\nname=Perforce\nbaseurl=http://package.perforce.com/yum/rhel/6/x86_64\nenabled=1\ngpgcheck=1\n' > /etc/yum.repos.d/peforce.repo
RUN rpm --import http://package.perforce.com/perforce.pubkey
RUN yum clean all && yum update -y
RUN yum install -y epel-release cronie-anacron tar gzip curl
RUN yum clean all && yum update -y && yum makecache
RUN curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz | tar zxf - -C /
RUN curl -sSL https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64 > /usr/bin/gosu && chmod +x /usr/bin/gosu

ENTRYPOINT ["/init"]
