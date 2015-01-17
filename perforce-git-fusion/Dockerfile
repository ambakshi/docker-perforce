FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum clean all && yum install -y perforce-git-fusion openssh-server
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
RUN sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su
RUN yum install -y epel-release
RUN rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-13.ius.centos6.noarch.rpm
RUN yum install -y python33 python33-tools python33-devel python33-libs
RUN yum install -y which
RUN mkdir -p -m 0700 /root/.ssh
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 0400 /root/.ssh/authorized_keys

ADD ./run.sh /
EXPOSE 22
CMD ["/run.sh"]
