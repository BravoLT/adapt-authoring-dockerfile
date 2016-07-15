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
RUN      git clone https://github.com/BravoLT/adapt_authoring.git
WORKDIR "/adapt_authoring"
RUN     git checkout feature/1-making-it-work-with-docker
RUN     npm install --production

RUN		sudo apt-get install net-tools
RUN     sudo apt-get install nano
RUN     sudo npm install sweetalert
RUN     echo 'Y' | sudo apt-get install expect

EXPOSE 80
EXPOSE 5000

RUN cd /adapt_authoring
RUN echo -e "---------------------- Adding the expect-adapt shell script ----------------------\n"
ADD expect-adapt.sh /adapt_authoring/expect-adapt.sh
CMD chmod 755 expect-adapt.sh
#RUN service mongodb start && expect /adapt_authoring/expect-adapt.sh && node server
#RUN sudo service mongodb start && expect /adapt_authoring/expect-adapt.sh && node server
#RUN sudo service mongodb start 
RUN sudo apt-get install mongodb
RUN service mongodb start
RUN expect /adapt_authoring/expect-adapt.sh
RUN node server
