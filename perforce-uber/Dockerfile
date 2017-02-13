FROM phusion/baseimage:0.9.16
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN curl -fsSL http://package.perforce.com/perforce.pubkey | apt-key add - 
RUN echo 'deb http://package.perforce.com/apt/ubuntu precise release' > /etc/apt/sources.list.d/perforce.sources.list
RUN apt-get update -yq && apt-get install -yqq --no-install-recommends helix-cli helix-p4d helix-proxy helix-git-fusion helix-git-fusion-trigger helix-swarm helix-swarm-triggers

## Enable ssh
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN mkdir -m 0755 -p /etc/myinit.d /etc/container_environment /etc/service/p4d /etc/service/p4swarm
ADD ./env.d/ /etc/container_environment
RUN gpasswd -a perforce docker_env

EXPOSE 22 80 443 1666 1667 8080
ENV P4NAME=p4depot P4ROOT=/data/p4depot P4SSLDIR=/data/p4depot/ssl P4PORT=ssl:1666 P4USER=perforce
VOLUME ["/data"]

ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./p4d.run  /etc/service/p4d/run
ADD ./p4d.init /etc/my_init.d/10-p4d.sh

CMD ["/sbin/my_init"]
