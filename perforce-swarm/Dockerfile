FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ARG P4D_VERSION
ENV P4D_VERSION=$P4D_VERSION

RUN yum update -y \
    && yum install -y centos-release-scl  \
    && yum install -y sclo-php72-php-pecl-igbinary.x86_64 \
    && yum install -y helix-swarm-${P4D_VERSION} helix-swarm-triggers httpd \
    && yum clean all \
    && rm -rf /var/cache/yum

## ** OPTIONAL **

RUN for ii in rsyslog crond httpd; do systemctl enable $ii; done
ENV P4PORT perforce:1666
ENV P4USER swarm
ENV P4PASSWD swarm
ENV MXHOST localhost

EXPOSE 80 443

ADD ./run.sh /

ENTRYPOINT ["/run.sh"]
CMD ["/usr/sbin/init"]
