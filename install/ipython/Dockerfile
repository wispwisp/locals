FROM ubuntu:latest

RUN apt update && apt install -y ipython python3-pip python-pip

RUN useradd -ms /bin/bash me
USER me

WORKDIR /home/me

