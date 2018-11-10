FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ARG P4_VERSION=19.1

RUN yum install -y centos-release-scl-rh centos-release-scl openssh-server && \
    yum install -y \
    helix-swarm-20${P4_VERSION} \
    helix-cli-base-20${P4_VERSION} \
    helix-swarm-triggers-20${P4_VERSION} \
    rsyslog
## RUN yum install -y php-pecl-imagick

ENV P4PORT perforce:1666
ENV P4USER swarm
ENV P4PASSWD swarm
ENV MXHOST localhost

EXPOSE 80 443

ADD ./run.sh /

CMD ["/run.sh"]
