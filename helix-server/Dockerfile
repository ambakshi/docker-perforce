FROM ubuntu:16.04

RUN apt-get update && apt-get install -y wget vim

ADD ./perforce.list /etc/apt/sources.list.d/
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add -
RUN apt-get update && apt-get install -y helix-p4d helix-p4dctl

EXPOSE 1666
ENV NAME p4depot
ENV P4PORT 1666
ENV P4USER p4admin
ENV P4CONFIG .p4config
ENV DATAVOLUME /data
VOLUME ["$DATAVOLUME"]

ADD ./p4-users.txt /root/
ADD ./p4-groups.txt /root/
ADD ./p4-protect.txt /root/
ADD ./setup-perforce.sh /usr/local/bin/
ADD ./run.sh /

CMD ["/bin/bash"]
