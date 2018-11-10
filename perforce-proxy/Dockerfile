FROM ambakshi/perforce-base
MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ARG P4_VERSION

#RUN curl -fsSL http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4 -o /usr/bin/p4 && chmod +x /usr/bin/p4 && \
    #    curl -fsSL http://cdist2.perforce.com/perforce/r${P4_VERSION}/bin.linux26x86_64/p4p -o /usr/bin/p4p && chmod +x /usr/bin/p4p
RUN yum install -y helix-proxy-20${P4_VERSION} && \
    yum clean all --enablerepo='*' && \
    rm -rf /var/cache/yum/*

ENV P4TARGET perforce:1666
ENV P4PORT 1666
ENV P4PCACHE /cache

VOLUME ["$P4PCACHE"]

EXPOSE 1666

CMD ["/usr/bin/p4p"]
