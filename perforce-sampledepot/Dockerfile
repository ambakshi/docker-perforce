FROM ambakshi/perforce-server
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y curl tar wget
RUN yum install -y cronie-anacron

VOLUME /data
EXPOSE 1666
ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
