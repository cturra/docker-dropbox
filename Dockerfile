FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
ENV DROPBOX_VERSION 53.4.67
ENV ARCH            86_64

RUN apt-get -q update               \
 && apt-get -y install libglib2.0-0 \
                       supervisor   \
                       wget         \
 && rm -rf /var/lib/apt/lists/*

COPY assets/dropboxd.conf /etc/supervisor/conf.d/dropboxd.conf

# download and install dropbox (headless)
# more details about this installation at:
# - https://www.dropbox.com/install?os=lnx
RUN wget -O /tmp/dropbox.tgz            \
         -q https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x${ARCH}-${DROPBOX_VERSION}.tar.gz \
 && tar -zxf /tmp/dropbox.tgz -C /dropbox/ \
 && rm -f /tmp/dropbox.tgz

# download the Dropbox python management script
RUN wget -O /root/dropbox.py \
         -q http://www.dropbox.com/download?dl=packages/dropbox.py

# rename directory to .dropbox-dist for better maintainence
RUN mv /dropbox/dropbox-lnx.x${ARCH}-${DROPBOX_VERSION} /dropbox/.dropbox-dist

# kick off supervisord+dropbox
ENTRYPOINT [ "/usr/bin/supervisord" ]
