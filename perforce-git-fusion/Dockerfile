FROM ambakshi/perforce-server
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN yum install -y helix-git-fusion helix-git-fusion-3rdparty-git helix-git-fusion-trigger openssh-server \
    && systemctl enable sshd \
    && yum clean all \
    && rm -rf /var/cache/yum/*

RUN sed -i -r 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd; \
    sed -i -r 's@session\s*required\s*pam_limits.so@session optional pam_limits.so@g' /etc/pam.d/su*; \
    sed -i -r 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su*; \
    sed -i -r 's@^#?PermitRootLogin .*$@PermitRootLogin yes@' /etc/ssh/sshd_config

EXPOSE 22 80

ADD ./run.sh /
ADD ./setup-git-fusion.sh /usr/local/bin/
CMD ["/run.sh"]
