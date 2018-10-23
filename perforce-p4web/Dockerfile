FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

# This is the last version of p4web I could find
ENV P4WEB_VERSION 12.1

RUN useradd -m -s /bin/bash perforce
RUN curl -o /usr/bin/p4web -sSL "https://swarm.workshop.perforce.com/downloads/guest/perforce_software/p4web/main/bin/r${P4WEB_VERSION}/bin.linux26x86_64/p4web" && chmod +x /usr/bin/p4web
ENV P4PORT=perforce:1666 P4CLIENT=myclient P4USER=perforce P4PASSWD=pass P4HOST=host
EXPOSE 8080
CMD ["/usr/bin/p4web","-b","-U","${P4USER}","-w","8080"]

