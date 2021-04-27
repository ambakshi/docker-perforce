FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ARG P4_VERSION=20.1
ENV P4_VERSION=$P4_VERSION

RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4 && mv p4 /usr/bin/p4 && chmod +x /usr/bin/p4
RUN curl -sSL -O http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4p && mv p4p /usr/bin/p4p && chmod +x /usr/bin/p4p

ENV P4TARGET=perforce:1666
ENV P4PORT=1666
ENV P4PCACHE=/cache

VOLUME ["$P4PCACHE"]

EXPOSE 1666

CMD ["/usr/bin/p4p"]
