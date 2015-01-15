FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum clean all && yum install -y perforce-swarm cronie-anacron epel-release
RUN yum install -y perforce-swarm-triggers php-pecl-imagick
RUN yum install -y perforce-swarm-optional

ADD ./run.sh /
EXPOSE 80
CMD ["/run.sh"]
