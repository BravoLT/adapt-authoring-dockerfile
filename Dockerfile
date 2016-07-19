# Adapt authoring server based on Ubuntu 16.04
FROM ubuntu:16.04
MAINTAINER Michael Nishizawa "michael.nishizawa@bravolt.com"
RUN echo -e "----------------------\nStarting apt installations - Fresh\n----------------------"

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
RUN chmod 755 expect-adapt.sh
RUN mongod --config /etc/mongodb.conf --smallfiles & expect /adapt_authoring/expect-adapt.sh 
# HYPOTHESIS: Doing an install of grunt build:dev or grunt build:test, then a restart of node server gets it to work 
#(as of 07/19/16 I can't get grunt build:prod to work because origin.js says: {"statusCode":"not-authenticated"})
#RUN grunt build:dev
# ---- output
# root@9521f0e356b8:/adapt_authoring# grunt build:dev
#Running "build:dev" (build) task
#
#Running "requirePlugins" task
#
#Running "merge-json:en" (merge-json) task
#File "routes/lang/en.json" created.
#
#Running "copy:main" (copy) task
#Created 1 directories, copied 366 files
#
#Running "less:dist" (less) task
#File frontend/src/adaptbuilder/css/adapt.css created.
#
#Running "handlebars:compile" (handlebars) task
#File frontend/src/templates/templates.js created.
#
#Running "requirejs:dev" (requirejs) task
#
# ---- end output build:dev
#CMD mongod --config /etc/mongodb.conf --smallfiles & node server
CMD mongod --config /etc/mongodb.conf --smallfiles
#CMD node server
RUN echo -e "\n\nFinished DockerFile install!!\n\n"
