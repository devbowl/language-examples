FROM neprune/ubuntu-base:latest

# Python 2 set-up.
RUN apt-get update && apt-get install -y \
    python

ADD https://bootstrap.pypa.io/get-pip.py .
RUN python get-pip.py
RUN pip install virtualenv

COPY python2 /home/user/projects/python2
WORKDIR /home/user/projects/python2
RUN virtualenv venv
RUN /bin/bash -c "source venv/bin/activate && pip install -r requirements.txt"
WORKDIR /

# Python 3 set-up.
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install -y \
    python3.6

COPY python3 /home/user/projects/python3
WORKDIR /home/user/projects/python3
RUN virtualenv -p /usr/bin/python3.6 venv
RUN /bin/bash -c "source venv/bin/activate && pip install -r requirements.txt"
WORKDIR /

# Docs setup.
COPY docs /home/user/docs
