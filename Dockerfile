FROM ubuntu:22.04

# Set ENV for headless apt
ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /opt/pqcli-stream/.config/pqcli

WORKDIR /opt/pqcli-stream/

COPY music ./music
COPY run.sh ./
COPY stream.sh ./
COPY Xresources /root/.Xresources
COPY xorg.conf /usr/share/X11/xorg.conf.d/
COPY initial-save-data/save.dat ./.config/pqcli/save.dat

RUN chmod +x ./*.sh && apt update && apt upgrade -y
RUN apt install -y --no-install-recommends software-properties-common gpg-agent locales xfonts-base
RUN apt install -y --no-install-recommends python3 python3-pip python3-venv
RUN apt install -y --no-install-recommends  tzdata lightdm xterm xvfb ffmpeg x11-xserver-utils git detox

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN update-locale LANG=en_US.UTF-8
RUN detox ./music/*

ENV XDG_CONFIG_HOME=/opt/pqcli-stream/.config
ENV TERM=xterm-256color
ENV LANG=en_US.UTF-8

RUN git clone https://github.com/rr-/pq-cli.git
RUN pip3 install ./pq-cli
 
CMD ./run.sh
