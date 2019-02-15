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

RUN pip uninstall wheel
RUN pip install wheel
RUN pip install numpy==1.11.2 scipy==0.18.1 matplotlib==2.1.2
RUN git clone https://github.com/commaai/openpilot.git /data/openpilot
RUN mv /data/openpilot/requirements_openpilot.txt /data/requirements.txt
RUN pip install -r /data/requirements.txt

ENV PYTHONPATH /data/openpilot:$PYTHONPATH





# INSTALL ZMQ
# COPY zmq_install.sh /usr/local/bin/zmq_install.sh
# RUN chmod +x /usr/local/bin/zmq_install.sh
# RUN /usr/local/bin/zmq_install.sh

# INSTALL CAPNP
# COPY capnp_install.sh /usr/local/bin/capnp_install.sh
# RUN chmod +x /usr/local/bin/capnp_install.sh
# RUN /usr/local/bin/capnp_install.sh

# RUN git clone https://github.com/commaai/openpilot-tools.git /data/openpilot/openpilot_tools

# COPY requirements_op_clean.txt /data/openpilot/requirements.txt
# RUN cd /data/openpilot/openpilot_tools && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pipenv install

# RUN cd /data/openpilot && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pipenv install
# RUN echo 'export PYTHONPATH="$PYTHONPATH:<path-to-openpilot>"' >> ~/.bashrc
# # RUN source ~/.bashrc
# RUN mkdir -p /data/params

# COPY entrypoint.sh /usr/local/bin/entrypoint.sh
# RUN chmod +x /usr/local/bin/entrypoint.sh
# COPY ssh_key /home/root/.ssh/
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
RUN mkdir -p /data/openpilot/selfdrive/test/out
RUN make -C /data/openpilot/selfdrive/controls/lib/longitudinal_mpc clean
RUN make -C /data/openpilot/selfdrive/controls/lib/lateral_mpc clean
CMD tail -f /dev/null