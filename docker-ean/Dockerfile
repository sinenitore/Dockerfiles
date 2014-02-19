#
# Node.js Dockerfile
#
# https://github.com/dockerfile/nodejs
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Node.js
RUN apt-get install -y software-properties-common python python-software-properties g++ make git
RUN add-apt-repository -y ppa:chris-lea/node.js  
RUN apt-get update  
RUN apt-get install -y nodejs

# Container cleanup
# Removed unnecessary packages
RUN apt-get purge -y software-properties-common g++ make  
RUN apt-get autoremove -y  
RUN apt-get clean all

# Append to $PATH variable.
RUN echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bash_profile

ENV VER_UPDATE 0.02

# Install MEAN components
RUN npm install -g jade
RUN npm install -g express
RUN npm install -g mongoose
RUN npm install -g bower
RUN npm install -g nodemon

# Create volume mount for working directory. Mount host dir here.
RUN mkdir -p /srv/express

# Set environment vairables or bash script run
WORKDIR /srv/express
ENV DO_INIT 0
ENV WORK_DIR /srv/express

ADD ean.init.sh /srv/
RUN chmod +x /srv/ean.init.sh
RUN chmod +x /srv/express

# Set permissions for easy writing elsewhere
RUN chmod -R g+rw /srv/express && chmod -R o+rw /srv/express

VOLUME ["/srv/express"]

# Expose default express port
EXPOSE 3000

CMD ["/srv/ean.init.sh"]
