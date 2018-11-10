ARG P4_BASEIMAGE=centos@sha256:a799dd8a2ded4a83484bbae769d97655392b3f86533ceb7dd96bbac929809f3c
FROM $P4_BASEIMAGE
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV container docker

# See: https://hub.docker.com/_/centos/
RUN cd /lib/systemd/system/sysinit.target.wants/ && \
	for i in *; do \
		[ $i == systemd-tmpfiles-setup.service ] || rm -vf $i ; \
	done ; \
	rm -vf /lib/systemd/system/multi-user.target.wants/* && \
	rm -vf /etc/systemd/system/*.wants/* && \
	rm -vf /lib/systemd/system/local-fs.target.wants/* && \
	rm -vf /lib/systemd/system/sockets.target.wants/*udev* && \
	rm -vf /lib/systemd/system/sockets.target.wants/*initctl* && \
	rm -vf /lib/systemd/system/basic.target.wants/* && \
	rm -vf /lib/systemd/system/anaconda.target.wants/* && \
	mkdir -p /etc/selinux/targeted/contexts/ && \
	echo '<busconfig><selinux></selinux></busconfig>' > /etc/selinux/targeted/contexts/dbus_contexts

ARG GOSU_VERSION=1.11
ARG S6_OVERLAY_VERSION=1.22.1.0
ARG TINI_VERSION=0.18.0
ARG SYSTEMCTL_GITSHA1=73b5aff2ba6abfd254d236f1df22ff4971d44660

RUN sed -ir '/\[updates\].*/a enabled=1' /etc/yum.repos.d/CentOS-Base.repo && \
    yum install -y epel-release cronie-anacron tar gzip curl openssl which sudo initscripts sysvinit at && \
    echo -ne '[perforce]\nname=Perforce\nbaseurl=http://package.perforce.com/yum/rhel/7/x86_64\nenabled=1\ngpgcheck=1\n' > /etc/yum.repos.d/perforce.repo && \
    rpm --import https://package.perforce.com/perforce.pubkey && \
    yum clean all --enablerepo='*' && \
    rm -rf /var/cache/yum

RUN curl -fsSL https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/${SYSTEMCTL_GITSHA1}/files/docker/systemctl.py -o /bin/systemctl && \
    curl -fsSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar zxf - -C / --keep-directory-symlink --exclude ./usr/bin/execlineb && \
    curl -fsSL https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-amd64 -o /usr/bin/tini && \
    curl -fsSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 -o /usr/bin/gosu && \
    chmod +x /bin/systemctl /usr/bin/gosu /usr/bin/tini

ENTRYPOINT ["/init"]
