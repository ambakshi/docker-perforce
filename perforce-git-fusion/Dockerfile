FROM ambakshi/perforce-server
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV FUSION_VERSION 2015.3
ENV REFRESHED_AT 2015-11-15

RUN yum install -y helix-git-fusion-$FUSION_VERSION helix-git-fusion-3rdparty-git helix-git-fusion-trigger
RUN yum install -y  openssh-server
#RUN rpm -Uvh http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/ius-release-1.0-13.ius.centos6.noarch.rpm
#RUN yum install -y  openssh-server python33 python33-tools python33-devel python33-libs
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
RUN sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su
RUN sed -i 's@PermitRootLogin without-password@PermitRootLogin yes@' /etc/ssh/sshd_config

EXPOSE 22 1666

ADD ./run.sh /
CMD ["/run.sh"]
