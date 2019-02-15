FROM ubuntu:16.04

ENV PYTHONUNBUFFERED 1

# SYSTEM USER ARGS FOR ADDING EON-LIKE ROOT USER
# Although we don't normally need openssh-server on a docker container,
# one of the goals of this project is to mimic an "eon-like" experience 
# as close as possible.
ARG SSH_MASTER_USER
ARG SSH_MASTER_PASS

# SYSTEM DEPENDENCIES
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    sudo \
    git \
    openssh-server \
    build-essential \
    clang \
    vim \
    screen \
    wget \
    bzip2 \
    curl \
    vim \
    libglib2.0-0 \
    python-dev \
    python-pip \
    python-setuptools \
    capnproto \
    libcapnp-dev \
    libzmq5-dev \
    libffi-dev \
    libusb-1.0-0 \
    libssl-dev \
    ocl-icd-libopencl1 \
    ocl-icd-opencl-dev \
    opencl-headers

# SETUP USER
COPY user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh
RUN /usr/local/bin/user.sh
RUN cp /bin/bash /usr/bin/bash

RUN git config --global http.sslVerify false

# SETUP SSH and SSHD
COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config

RUN pip install --upgrade pip

# Might not be necessary but seems to be working okay to resolve wheel issues.
RUN pip uninstall wheel
RUN pip install wheel

# INSTALL OPENPILOT
RUN pip install numpy==1.11.2 scipy==0.18.1 matplotlib==2.1.2
RUN git clone https://github.com/commaai/openpilot.git /data/openpilot

# This seems silly but maybe it's required... was mimicing the 
# Dockerfile.openpilot locations minus the /tmp/
RUN mv /data/openpilot/requirements_openpilot.txt /data/requirements.txt
RUN pip install -r /data/requirements.txt

ENV PYTHONPATH /data/openpilot:$PYTHONPATH

# 
# BEGIN OPENPILOT TOOLS INSTALLATION
#

# Install AV libraries
RUN apt-get install ffmpeg -y
RUN apt-get install libavformat-dev -y
RUN apt-get install libavcodec-dev -y
RUN apt-get install libavdevice-dev -y
RUN apt-get install libavutil-dev -y
RUN apt-get install libswscale-dev -y
RUN apt-get install libavresample-dev -y
RUN apt-get install libavfilter-dev -y

# Install extra build tools
RUN apt-get install pkg-config clang-3.8 -y

# Install libarchive-dev
RUN apt-get install libarchive-dev -y

# Install python-qt4
RUN apt-get install python-qt4 -y

# Install ZeroMQ
COPY zmq_install.sh /usr/local/bin/zmq_install.sh
RUN chmod +x /usr/local/bin/zmq_install.sh
RUN /usr/local/bin/zmq_install.sh

# Install Capnp
RUN apt-get install autogen autoconf libtool -y
COPY capnp_install.sh /usr/local/bin/capnp_install.sh
RUN chmod +x /usr/local/bin/capnp_install.sh
RUN /usr/local/bin/capnp_install.sh

RUN git clone https://github.com/commaai/openpilot-tools.git /data/openpilot/openpilot_tools

RUN pip install -r /data/openpilot/openpilot_tools/requirements.txt

RUN echo 'export PYTHONPATH="$PYTHONPATH:/data/openpilot"' >> ~/.bashrc
RUN mkdir -p /data/params

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
RUN mkdir -p /data/openpilot/selfdrive/test/out
RUN make -C /data/openpilot/selfdrive/controls/lib/longitudinal_mpc clean
RUN make -C /data/openpilot/selfdrive/controls/lib/lateral_mpc clean
CMD tail -f /dev/null