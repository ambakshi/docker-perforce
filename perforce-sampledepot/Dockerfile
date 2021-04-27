ARG P4D_VERSION
FROM ambakshi/perforce-server:${P4D_VERSION}
ARG P4D_VERSION
LABEL MAINTAINER Amit Bakshi <ambakshi@gmail.com>

ENV P4ROOT=$DATAVOLUME/PerforceSample
RUN curl -fL ftp://ftp.perforce.com/perforce/tools/sampledepot.tar.gz -o /opt/perforce/sampledepot.tar.gz

RUN mkdir -p $P4ROOT && \
    tar zxf /opt/perforce/sampledepot.tar.gz --strip-components=1 -C $P4ROOT && \
    p4d -r $P4ROOT -jr $P4ROOT/checkpoint && \
    p4d -r $P4ROOT -xu && \
    chown -R perforce:perforce $P4ROOT && \
    chmod 0700 $P4ROOT

RUN echo "P4ROOT=$P4ROOT" >> /etc/default/perforce


