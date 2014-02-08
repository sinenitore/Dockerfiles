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

# Install MEAN components
RUN npm install -g jade
RUN npm install -g express
RUN npm install -g mongoose
RUN npm install -g bower
RUN npm install -g nodemon

# Create volume mount for working directory. Mount host dir here.
RUN mkdir -p /srv/express

# Create express app
#RUN cd /srv/express
#WORKDIR /srv/express
#RUN express -s -c less ean_app

# Add requirements and run install
WORKDIR /srv/express/ean_app
ENV gitrepo https://github.com/sinenitore/dyn-proxy.git
#ADD package.json /srv/express/ean_app/package.json
#ADD bowerrc /srv/express/ean_app/.bowerrc
#ADD bower.json /srv/express/ean_app/bower.json
RUN git init .
RUN git remote add origin $gitrepo
ENV app_ver 0.01
RUN git pull $gitrepo
RUN npm install

# Set permissions for easy writing elsewhere
RUN chmod -R g+rw /srv/express && chmod -R o+rw /srv/express

VOLUME ["/srv/express"]

# Expose default express port
EXPOSE 3000


ENTRYPOINT ["nodemon", "--watch ./routes", "--watch ./views"]  
CMD ["./app.js"]
