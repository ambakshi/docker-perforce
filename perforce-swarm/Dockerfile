FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV REFRESHED_AT 2019-05-01

RUN yum install -y helix-swarm helix-swarm-triggers
## RUN yum install -y php-pecl-imagick

ENV P4PORT perforce:1666
ENV P4USER swarm
ENV P4PASSWD swarm
ENV MXHOST localhost

EXPOSE 80 443

ADD ./run.sh /

CMD ["/run.sh"]
