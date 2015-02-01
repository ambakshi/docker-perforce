FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV SWARM_VERSION 2014.4
RUN yum install -y perforce-swarm-$SWARM_VERSION perforce-swarm-triggers-$SWARM_VERSION
## RUN yum install -y php-pecl-imagick

ENV P4PORT perforce:1666
ENV P4USER swarm
ENV P4PASSWD swarm
ENV MXHOST localhost

EXPOSE 80 443

ADD ./run.sh /

CMD ["/run.sh"]
