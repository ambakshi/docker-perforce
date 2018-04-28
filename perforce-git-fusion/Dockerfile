FROM ambakshi/perforce-server
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y helix-git-fusion helix-git-fusion-3rdparty-git helix-git-fusion-trigger openssh-server

RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd
RUN sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su
RUN sed -i 's@PermitRootLogin without-password@PermitRootLogin yes@' /etc/ssh/sshd_config

EXPOSE 22 80

ADD ./run.sh /
ADD ./setup-git-fusion.sh /usr/local/bin/
CMD ["/run.sh"]
