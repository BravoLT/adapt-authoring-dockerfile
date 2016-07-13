# Adapt authoring server based on Ubuntu 16.04
FROM ubuntu:16.04
MAINTAINER Michael Nishizawa "michael.nishizawa@bravolt.com"
RUN echo -e "----------------------\nStarting apt installations \n----------------------"

RUN     apt-get update
RUN     apt-get install --yes build-essential git sudo curl mongodb ffmpeg frei0r-plugins
RUN     curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
RUN     apt-get install --yes nodejs

RUN echo -e "----------------------\nStarting npm installations \n----------------------"
RUN     /usr/bin/sudo npm install -g grunt-cli adapt-cli n
RUN echo -e "----------------------\nRunning node upgrade.js via n stable \n----------------------"
RUN     /usr/bin/sudo n stable

#RUN     git clone https://github.com/adaptlearning/adapt_authoring.git
RUN echo -e "-------- xx \n----------------------"
RUN      git clone https://github.com/BravoLT/adapt_authoring.git
WORKDIR "/adapt_authoring"
RUN     git checkout feature/1-making-it-work-with-docker
RUN     npm install --production

RUN		sudo service mongodb start
RUN		sudo apt-get install net-tools
RUN     sudo apt-get install nano
RUN     sudo npm install sweetalert

EXPOSE 80
EXPOSE 5000

RUN echo -e "----------------------\nRunning adapt install, please install on port 80 \n----------------------"
RUN pwd
RUN cd /adapt_authoring
RUN pwd
RUN sudo service mongodb start && node install && node server
#RUN echo -e "----------------------\nRunning adapt server \n----------------------"
#RUN pwd
#RUN node server
#RUN echo -e "----------------------\nShould be good to go :) \n----------------------"
