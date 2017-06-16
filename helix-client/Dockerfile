FROM ubuntu:16.04

RUN apt-get update && apt-get install -y wget vim

ADD ./perforce.list /etc/apt/sources.list.d/
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add -
RUN apt-get update && apt-get install -y helix-cli

ADD ./profile /root/.profile

CMD ["/bin/bash","-l"]
