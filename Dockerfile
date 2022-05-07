FROM debian:buster-slim

ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
  apt-get install -y git python3 python3-dev python3-pip curl build-essential && \
  c_rehash && \
  apt-get autoremove -y && \
  apt-get clean && \
  useradd --no-log-init mycroft -m

# the lines above are kept static so that docker layer is shared and cached among all containers
RUN apt-get install -y portaudio19-dev libpulse-dev swig

USER mycroft


COPY . /tmp/ovos-audio
RUN pip3 install /tmp/ovos-audio

# TODO remove this, missing dependency in ovos-core
RUN pip3 install python-dateutil

ENTRYPOINT mycroft-audio