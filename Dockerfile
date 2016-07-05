# This image will be based on the official nodejs docker image
FROM node:latest

MAINTAINER lucile coutouly <lucile.coutouly@obs-nancay.fr>

# Set in what directory commands will run
WORKDIR /data

# Put all our code inside that directory that lives in the container

COPY package.json /data

# Install dependencies
RUN npm install -g bower && npm install

# copy bower config frontend/bower.json
COPY  frontend /data/frontend
WORKDIR /data/frontend
RUN  bower install --config.interactive=false --allow-root
RUN ln -s ../bower_components app/bower_components

# source of code
VOLUME /data/frontend/app

# Tell Docker we are going to use this port
EXPOSE 80
WORKDIR /data
# The command to run our app when the container is run
CMD ["node", "frontend/server.js"]
