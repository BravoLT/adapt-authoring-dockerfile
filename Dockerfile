# Adapt authoring server based on Ubuntu 16.04
FROM ubuntu:16.04
MAINTAINER Michael Nishizawa "michael.nishizawa@bravolt.com"
RUN echo -e "----------------------\nStarting apt installations \n----------------------"

RUN     apt-get update
RUN     apt-get install --yes build-essential git sudo curl mongodb ffmpeg frei0r-plugins
RUN     curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN     apt-get install --yes nodejs

RUN echo -e "----------------------\nStarting npm installations \n----------------------"

RUN     /usr/bin/sudo npm install -g grunt-cli adapt-cli
RUN     git clone https://github.com/adaptlearning/adapt_authoring.git
WORKDIR "/adapt_authoring"
RUN     npm install --production

#RUN echo -e "----------------------\nRunning adapt install, please install on port 80 \n----------------------"
RUN node install
#RUN echo -e "----------------------\nRunning adapt server \n----------------------"
RUN node server
#RUN echo -e "----------------------\nShould be good to go :) \n----------------------"
EXPOSE 80
