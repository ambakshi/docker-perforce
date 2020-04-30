FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>


RUN yum install -y centos-release-scl-rh \
    && yum install -y helix-swarm helix-swarm-triggers httpd \
    && yum clean all \
    && rm -rf /var/cache/yum

## ** OPTIONAL **
## RUN yum install -y php-pecl-imagick

RUN for ii in rsyslog crond httpd; do systemctl enable $ii; done
ENV P4PORT perforce:1666
ENV P4USER swarm
ENV P4PASSWD swarm
ENV MXHOST localhost

EXPOSE 80 443

ADD ./run.sh /

ENTRYPOINT ["/run.sh"]
CMD ["/usr/sbin/init"]
