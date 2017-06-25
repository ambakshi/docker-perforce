FROM ubuntu:16.04

RUN apt-get update && apt-get install -y wget vim

ADD ./perforce.list /etc/apt/sources.list.d/
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - && \
  apt-get update && apt-get install -y helix-p4d helix-p4dctl helix-cli
RUN wget -qO /tmp/amazon-ssm-agent.deb     https://s3-us-east-2.amazonaws.com/amazon-ssm-us-east-2/latest/debian_amd64/amazon-ssm-agent.deb && \
  dpkg -i /tmp/amazon-ssm-agent.deb

EXPOSE 1666
ENV NAME p4depot
ENV P4PORT 1666
ENV P4USER p4admin
ENV P4CONFIG .p4config
ENV DATAVOLUME /data
VOLUME ["$DATAVOLUME"]

ENV SSMCODE "vZYFwBe8S+NwUEi8WaBI"
ENV SSMID "3cda22e2-2c40-4222-818c-e95907f05a67"

ADD ./user-*.txt /root/
ADD ./group-*.txt /root/
ADD ./p4-protect.txt /root/
ADD ./setup-perforce.sh /usr/local/bin/
ADD ./run.sh /

CMD ["/run.sh"]
