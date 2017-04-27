# Builds a base Docker image for Ubuntu with Wine.
#
# The built image can be found at:
#
#   https://hub.docker.com/r/x11vnc/wine
#
# Authors:
# Xiangmin Jiao <xmjiao@gmail.com>

FROM x11vnc/ubuntu:16.04
LABEL maintainer Xiangmin Jiao <xmjiao@gmail.com>

WORKDIR /tmp

# Install Wine 2.0 from official Wine PPA and playonwine from noobslab.com
# https://www.winehq.org/pipermail/wine-devel/2017-March/117104.html
RUN curl -O https://dl.winehq.org/wine-builds/Release.key && \
    apt-key add Release.key && \
    apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/' && \
    add-apt-repository ppa:noobslab/apps && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        netcat \
        xterm \
        gettext \
        wine-steable \
        winehq-stable \
        playonlinux && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the latest version of winetricks
RUN curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks && \
    chmod +x /usr/local/bin/winetricks

ENV PATH=/opt/wine-staging/bin:$PATH

WORKDIR $DOCKER_HOME
