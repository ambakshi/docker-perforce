FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV SWARM_VERSION 2016.1
ENV REFRESHED_AT 2016-05-14

RUN yum install -y helix-swarm-$SWARM_VERSION helix-swarm-triggers
## RUN yum install -y php-pecl-imagick

ENV P4PORT perforce:1666
ENV P4USER swarm
ENV P4PASSWD swarm
ENV MXHOST localhost 

EXPOSE 80 443

ADD ./run.sh /

CMD ["/run.sh"]
