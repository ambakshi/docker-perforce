FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum clean all && yum install -y perforce-git-fusion openssh-server
ADD ./run.sh /
EXPOSE 22
CMD ["/run.sh"]
