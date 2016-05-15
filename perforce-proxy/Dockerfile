FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4P_VERSION 15.2
ENV REFRESHED_AT 2016-05-14

RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4D_VERSION}/bin.linux26x86_64/p4 && mv p4 /usr/bin/p4 && chmod +x /usr/bin/p4
RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4P_VERSION}/bin.linux26x86_64/p4p && mv p4p /usr/bin/p4p && chmod +x /usr/bin/p4p

ENV P4TARGET perforce:1666
ENV P4PORT 1666
ENV P4PCACHE /cache

VOLUME ["$P4PCACHE"]

EXPOSE 1666

CMD ["/usr/bin/p4p"]
