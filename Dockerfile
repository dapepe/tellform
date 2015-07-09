# DOCKER-VERSION 1.7.0

FROM ubuntu:13.10

# make sure apt is up to date
RUN apt-get update

MAINTAINER Matthias Luebken, matthias@catalyst-zero.com

# install nodejs and npm
RUN apt-get install -y nodejs npm git git-core

WORKDIR /home/mean

# Install Mean.JS Prerequisites
RUN npm install -g grunt-cli
RUN npm install -g bower

# Install Mean.JS packages
ADD package.json /home/mean/package.json
RUN npm install

# Manually trigger bower. Why doesnt this work via npm install?
ADD .bowerrc /home/mean/.bowerrc
ADD bower.json /home/mean/bower.json
RUN bower install --config.interactive=false --allow-root

# Make everything available for start
ADD . /home/mean

# currently only works for development
ENV NODE_ENV development

# Port 3000 for server
# Port 35729 for livereload
EXPOSE 3000 35729
CMD ["grunt"]
