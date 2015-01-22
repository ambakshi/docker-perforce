FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y perforce-swarm perforce-swarm-triggers php-pecl-imagick

ENV P4PORT perforce:1666
ENV P4USER swarm
ENV P4PASSWD swarm
ENV MXHOST localhost

EXPOSE 80

ADD ./run.sh /

CMD ["/run.sh"]
