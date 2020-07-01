FROM ubuntu:focal
WORKDIR /home/ubuntu
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y curl git gnupg2 locales make net-tools npm screen sudo tmux vim zsh

RUN sed -i -e 's/# \(en_US\.UTF-8 .*\)/\1/' /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN npm install -g c9
RUN git clone https://github.com/c9/core.git /c9 --depth 1
WORKDIR /c9
RUN ./scripts/install-sdk.sh
CMD [ "node", "server.js", "-p", "8080", "--listen", "0.0.0.0", "-w", "/home/ubuntu/", "-a", ":" ]
EXPOSE 8080
