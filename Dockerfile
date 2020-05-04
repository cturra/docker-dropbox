FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive
ENV DROPBOX_VERSION 96.4.172
ENV ARCH            86_64

RUN apt-get -q update                  \
 && apt-get -y install libc6           \
                       libglapi-mesa   \
                       libglib2.0-0    \
                       libxcb-dri2-0   \
                       libxcb-dri3-0   \
                       libxcb-glx0     \
                       libxcb-present0 \
                       libxcb-sync1    \
                       libxdamage1     \
                       libxfixes3      \
                       libxshmfence1   \
                       libxxf86vm1     \
                       supervisor      \
                       wget            \
 && rm -rf /var/lib/apt/lists/*

COPY assets/dropboxd.conf /etc/supervisor/conf.d/dropboxd.conf

# download and install dropbox (headless)
# more details about this installation at:
# - https://www.dropbox.com/install?os=lnx
RUN wget -O /tmp/dropbox.tgz            \
         -q https://clientupdates.dropboxstatic.com/dbx-releng/client/dropbox-lnx.x${ARCH}-${DROPBOX_VERSION}.tar.gz \
 && tar -zxf /tmp/dropbox.tgz -C /root/ \
 && rm -f /tmp/dropbox.tgz

# download the Dropbox python management script
RUN wget -O /root/dropbox.py \
         -q http://www.dropbox.com/download?dl=packages/dropbox.py

# move .dropbox-dist directory to /dropbox
RUN mv -f /root/.dropbox-dist /dropbox

# kick off supervisord+dropbox
ENTRYPOINT [ "/usr/bin/supervisord" ]
