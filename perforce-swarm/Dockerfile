FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y perforce-swarm perforce-swarm-triggers php-pecl-imagick

EXPOSE 80

ADD ./run.sh /

CMD ["/run.sh"]
