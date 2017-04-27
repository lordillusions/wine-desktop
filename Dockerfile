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

# Install Wine 2.6 from official Wine PPA
RUN curl -O https://dl.winehq.org/wine-builds/Release.key && \
    apt-key add Release.key && \
    apt-add-repository -y 'https://dl.winehq.org/wine-builds/ubuntu/' && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        netcat \
        xterm \
        gettext \
        wine-devel \
        winehq-devel && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install the latest version of winetricks
RUN curl -SL 'https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks' -o /usr/local/bin/winetricks && \
    chmod +x /usr/local/bin/winetricks

USER $DOCKER_HOME
WORKDIR $DOCKER_HOME
ENV WINEPREFIX=$DOCKER_HOME/win7 \
    WINEARCH=win32
