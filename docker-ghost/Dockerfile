# Install and Run Ghost 0.3.3

FROM ubuntu:precise
MAINTAINER thisguy

# Add sources and update
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y build-essential python-software-properties python g++ make software-properties-common sqlite3 libsqlite3-dev curl unzip

# Add node.js
RUN add-apt-repository ppa:chris-lea/node.js && \
	apt-get update && \
	apt-get install -y nodejs

# Download Ghost
RUN curl --location --progress -O https://ghost.org/zip/ghost-0.3.3.zip && \
	unzip -uo ghost-0.3.3.zip -d /srv/ghost && \
	rm ghost-0.3.3.zip

# Install / Configure Ghost
WORKDIR /srv/ghost
RUN sed -i -e 's/127.0.0.1/0.0.0.0/g' config.example.js && \
	npm config set strict-ssl false && \
	npm config set registry "http://registry.npmjs.org/" && \
	npm install --production

EXPOSE 2368

ENTRYPOINT ["npm", "start"]