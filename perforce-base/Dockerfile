ARG BASEOS
FROM $BASEOS
ARG BASEOS

ARG P4D_VERSION=2020.1
ENV P4D_VERSION=$P4D_VERSION

ENV container=docker

RUN \
    (cd /lib/systemd/system/sysinit.target.wants/ || exit 1; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -vf $i; done); \
    (cd /lib/systemd/system/ || exit 1; for i in systemd-machine-id-commit.service dracut*.service; do systemctl mask $i; done); \
    rm -vf /lib/systemd/system/local-fs.target.wants/*; \
    rm -vf /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -vf /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -vf /lib/systemd/system/basic.target.wants/*;\
    rm -vf /lib/systemd/system/anaconda.target.wants/*;\
    ln -sfnv /dev/null /etc/systemd/system/sys-fs-fuse-connections.mount; \
    mkdir -p /etc/selinux/targeted/contexts/;\
    echo '<busconfig><selinux></selinux></busconfig>' > /etc/selinux/targeted/contexts/dbus_contexts; \
    ln -sfnv multi-user.target /lib/systemd/system/default.target

RUN rm -fv /etc/yum.repos.d/CentOS-{Vault,fasttrack,Media}.repo \
    && echo 'exclude=kernel kernel-debug* kernel-devel* kernel-tools* linux-firmware microcode_ctl *.i?86 *.i686' >> /etc/yum.conf \
    && yum install -y epel-release cronie-anacron tar gzip curl openssl initscripts systemd systemd-sysv rsyslog sudo pam \
    && rm -fv /etc/yum.repos.d/epel-* \
    && sed -i -r 's/Defaults\s+requiretty/Defaults\t!requiretty/g' /etc/sudoers \
    && sed -i -r 's@^session\s+required\s+pam_limits.so@session optional pam_limits.so@g' /etc/pam.d/su* \
    && curl -fsSL https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 > /usr/bin/gosu && chmod +x /usr/bin/gosu \
    && for ii in crond.service rsyslog.service sshd.service; do ln -sfvn /usr/lib/systemd/system/${ii} /etc/systemd/system/multi-user.target.wants/${ii}; done \
    && echo 'NETWORKING=no' > /etc/sysconfig/network \
    && : > /etc/machine-id \
    && yum clean all --enablerepo='*' \
    && rm -rf /var/cache/yum/*


# Use http for the packages so it can be cached locally, but use https for the GPG key to ensure
# the GPG key is authentic
RUN vers=$(rpm -qf /etc/system-release --qf '%{VERSION}\n') && \
    echo -ne "[perforce]\nname=Perforce\nbaseurl=http://package.perforce.com/yum/rhel/${vers:0:1}/x86_64\nenabled=1\ngpgcheck=1\n" > /etc/yum.repos.d/perforce.repo && \
    rpm --import https://package.perforce.com/perforce.pubkey
RUN yum reinstall -y glibc && \
    yum clean all && \
    rm -rf /var/cache/yum/*

ENV LC_ALL=C.UTF-8


STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]
