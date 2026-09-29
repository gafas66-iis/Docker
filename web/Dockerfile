# -*- dockerfile -*-

FROM python:trixie

ENV CONTAINER_HOME=/var/www

ADD . $CONTAINER_HOME
WORKDIR $CONTAINER_HOME

RUN pip install -r $CONTAINER_HOME/requirements.txt

RUN apt-get update -yq \
    && apt-get install emacs x11-utils ruby openssh-server sudo -yq

# Add user and enable x11 through ssh
RUN useradd -s /bin/bash erik \
    && echo "erik:erik" | chpasswd \
    && usermod -aG sudo erik \
    && echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config \
    && echo "X11Forwarding yes"      >> /etc/ssh/sshd_config \
    && echo "X11DisplayOffset 10"    >> /etc/ssh/sshd_config \
    && echo "X11UseLocalhost yes"    >> /etc/ssh/sshd_config \
    && echo "AddressFamily inet"     >> /etc/ssh/sshd_config

# Start sshd daemon
CMD ["/usr/sbin/sshd", "-D"]

# End
