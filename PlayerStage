# -*- dockerfile -*-

FROM mybase:latest

# Playerstage specific here

RUN apt-get install cmake build-essential ruby -yq

WORKDIR /root

RUN pip install swig

RUN apt-get install libfltk1.3-dev -yq
RUN apt-get install libtirpc-dev -yq
RUN apt-get install libopencv-dev python3-opencv -yq
RUN apt-get install libboost-all-dev -yq

ADD Makefile /app/Makefile
WORKDIR /app

RUN make player
RUN make stage

# Start sshd daemon
CMD ["/usr/sbin/sshd", "-D"]

# End
################################################################################
