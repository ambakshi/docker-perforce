FROM ambakshi/perforce-server
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ARG P4_VERSION

RUN yum install -y \
    helix-git-fusion-20${P4_VERSION} \
    helix-swarm-triggers-20${P4_VERSION} \
    helix-cli-base-20${P4_VERSION} \
    helix-git-connector-20${P4_VERSION} \
    helix-git-fusion-3rdparty-git \
    helix-git-fusion-3rdparty-python3 \
    helix-git-fusion-3rdparty-python3-pytz \
    helix-git-fusion-3rdparty-pygit2 \
    openssh-server \
    && yum clean all --enablerepo='*' \
    && rm -rf /var/cache/yum

RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd \
    && sed -i 's@session\s*include\s*system-auth$@session optional system-auth@g' /etc/pam.d/su \
    && sed -i 's@PermitRootLogin without-password@PermitRootLogin yes@' /etc/ssh/sshd_config

EXPOSE 22 80

ADD ./run.sh /
ADD ./setup-git-fusion.sh /usr/local/bin/
CMD ["/run.sh"]
