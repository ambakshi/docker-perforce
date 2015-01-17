FROM ambakshi/perforce-server
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y curl tar wget
RUN wget -q ftp://ftp.perforce.com/perforce/tools/sampledepot.tar.gz

ADD ./run.sh  /

ENTRYPOINT ["/run.sh"]
