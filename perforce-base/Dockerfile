FROM centos:7.6.1810
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV REFRESHED_AT 2019-05-01

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

RUN yum install -y epel-release cronie-anacron tar gzip curl openssl && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN mkdir -p /tmp/s6 && \
    cd /tmp/s6 && \
    curl -fsSL https://github.com/just-containers/s6-overlay/releases/download/v1.22.1.0/s6-overlay-amd64.tar.gz | tar zxf - && \
    tar cf - init usr etc | (cd / && tar xf -) && \
    (cd /tmp/s6/bin && tar cf - .) | (cd /bin && tar xf -) && \
    cd / && rm -rf /tmp/s6 && \
    curl -fsSL https://github.com/tianon/gosu/releases/download/1.11/gosu-amd64 > /usr/bin/gosu && chmod +x /usr/bin/gosu

RUN echo -ne '[perforce]\nname=Perforce\nbaseurl=http://package.perforce.com/yum/rhel/7/x86_64\nenabled=1\ngpgcheck=1\n' > /etc/yum.repos.d/perforce.repo && \
    rpm --import http://package.perforce.com/perforce.pubkey

ENTRYPOINT ["/init"]
