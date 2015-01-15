FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y perforce-server
RUN yum install -y cronie-anacron

VOLUME /data
EXPOSE 1666
ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
