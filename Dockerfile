FROM debian:jessie

MAINTAINER chris turra <cturra@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV ARCH            86_64

RUN apt-get -qq update && \
    apt-get -yf install supervisor \
                        wget && \
    rm -rf /var/lib/apt/lists/*

COPY conf/dropboxd.conf /etc/supervisor/conf.d/dropboxd.conf

# download and install dropbox (headless)
# more details about this installation at:
# - https://www.dropbox.com/install?os=lnx
RUN wget -O /tmp/dropbox.tgz \
         -q https://www.dropbox.com/download?plat=lnx.x${ARCH} && \
    tar -zxf /tmp/dropbox.tgz -C /root/ && \
    rm -f /tmp/dropbox.tgz && \
    mkdir -p /dropbox/logs/supervisor

# kick off supervisord+dropbox
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/dropboxd.conf"]
