FROM centos:centos6
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV REFRESHED_AT 2015-09-09

RUN echo -ne '[perforce]\nname=Perforce\nbaseurl=http://package.perforce.com/yum/rhel/6/x86_64\nenabled=1\ngpgcheck=1\n' > /etc/yum.repos.d/peforce.repo
RUN rpm --import http://package.perforce.com/perforce.pubkey
RUN yum install -y perforce-cli which epel-release cronie-anacron
