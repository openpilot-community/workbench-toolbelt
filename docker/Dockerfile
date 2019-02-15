FROM ubuntu:16.04
 
ARG SSH_MASTER_USER
ARG SSH_MASTER_PASS
 
# INSTALL PREREQS
RUN apt-get update
RUN apt-get install -y --no-install-recommends git curl python-dev python3-dev gcc python-pip python3-pip ffmpeg libavformat-dev libavcodec-dev libavdevice-dev libavutil-dev libswscale-dev libavresample-dev libavfilter-dev autoconf automake clang clang-3.8 libtool pkg-config build-essential python-qt4 libarchive-dev
RUN pip install --upgrade pip>=18.0

# USING PIPENV
RUN curl https://raw.githubusercontent.com/kennethreitz/pipenv/master/get-pipenv.py | python

# SETUP SSH and SSHD
COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config

# SETUP USER
COPY user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh
RUN /usr/local/bin/user.sh
RUN cp /bin/bash /usr/bin/bash
RUN git config --global http.sslVerify false

# INSTALL ZMQ
COPY zmq_install.sh /usr/local/bin/zmq_install.sh
RUN chmod +x /usr/local/bin/zmq_install.sh
RUN /usr/local/bin/zmq_install.sh

# INSTALL CAPNP
COPY capnp_install.sh /usr/local/bin/capnp_install.sh
RUN chmod +x /usr/local/bin/capnp_install.sh
RUN /usr/local/bin/capnp_install.sh
RUN git clone https://github.com/commaai/openpilot.git /data/openpilot
RUN git clone https://github.com/commaai/openpilot-tools.git /data/openpilot/openpilot_tools

COPY requirements_op_clean.txt /data/openpilot/requirements.txt
RUN cd /data/openpilot/openpilot_tools && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pipenv install
# RUN cd /data/openpilot && mv requirements_openpilot.txt requirements.txt
RUN cd /data/openpilot && LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pipenv install
RUN echo 'export PYTHONPATH="$PYTHONPATH:<path-to-openpilot>"' >> ~/.bashrc
# RUN source ~/.bashrc
RUN mkdir -p /data/params

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
# COPY ssh_key /home/root/.ssh/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
 
CMD tail -f /dev/null