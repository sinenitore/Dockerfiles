#
# Ghost Dockerfile
#
# https://github.com/dockerfile/ghost
#

# Pull base image.
FROM dockerfile/nodejs

# Install Ghost
RUN useradd ghost
RUN mkdir -p /opt/ghost
RUN cd /opt/ghost && wget https://ghost.org/zip/ghost-0.4.0.zip -O ghost.zip
RUN cd /opt/ghost && unzip ghost.zip && rm -f ghost.zip
RUN cd /opt/ghost && npm install --production

# Mount volumes.
VOLUME /data/ghost

# Define working directory.
WORKDIR /opt/ghost

# Add files.
ADD run /usr/local/bin/run-ghost
ADD config.js /opt/ghost/config.js

RUN chown -R ghost:ghost /opt/ghost

ENV NODE_ENV production
ENV GHOST_URL http://my-ghost-blog.com

# Expose ports.
EXPOSE 2368

# Define an entry point.
CMD ["bash", "/usr/local/bin/run-ghost"]
