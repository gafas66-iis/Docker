# -*- dockerfile -*-

FROM python:trixie

RUN apt-get update -yq \
    && apt-get install pkg-config -yq \
    && apt-get install cmake build-essential -yq \
    && apt-get install openssh-server sudo -yq \
    && apt-get clean -y

RUN apt-get install emacs x11-utils ruby -yq

# Add user and enable x11 through ssh
RUN useradd -s /bin/bash erik \
    && echo "erik:erik" | chpasswd \
    && usermod -aG sudo erik \
    && echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config \
    && echo "X11Forwarding yes"      >> /etc/ssh/sshd_config \
    && echo "X11DisplayOffset 10"    >> /etc/ssh/sshd_config \
    && echo "X11UseLocalhost yes"    >> /etc/ssh/sshd_config \
    && echo "AddressFamily inet"     >> /etc/ssh/sshd_config

RUN apt-get install libfltk1.3-dev -yq
RUN apt-get install libtirpc-dev -yq

# Below is used in the katana player build
RUN apt-get install libopencv-dev python3-opencv libboost-all-dev -yq

# Minimal debian does not have all locales set up
RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8

ADD Makefile /app/Makefile
WORKDIR /app

# 'player' is called katana, linking to official name
RUN make player && cd /usr/local/bin;ln -s katana player
RUN make stage

# Start sshd daemon
CMD ["/usr/sbin/sshd", "-D"]

# End
################################################################################
