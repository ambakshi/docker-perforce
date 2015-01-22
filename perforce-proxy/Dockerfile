FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

RUN curl -O http://filehost.perforce.com/perforce/r14.2/bin.linux26x86_64/p4p && mv p4p /usr/bin/p4p && chmod +x /usr/bin/p4p

ENV P4TARGET perforce:1666
ENV P4PORT 1666
ENV P4PCACHE /cache

VOLUME $P4PCACHE

EXPOSE 1666

ENTRYPOINT ["/usr/bin/p4p"]
