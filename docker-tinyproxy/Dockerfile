# Dockerfile for TinyProxy, w/ whitelist.

FROM ubuntu:precise
MAINTAINER thisguy

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
	apt-get update && \
	apt-get upgrade

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_CALL en_US.UTF-8

# Prevent apt-get from complaining with: Unable to connect to Upstart
RUN dpkg-divert --local --rename --add /sbin/initctl && \
	ln -s /bin/true /sbin/initctl

# Install Tinyproxy
RUN apt-get -y install tinyproxy

# Copy tinyproxy.conf
ADD ./tinyproxy.conf /etc/tinyproxy.conf
ADD ./whitelist /srv/tinyproxy/whitelist

USER nobody
EXPOSE 31258
ENTRYPOINT ["/usr/sbin/tinyproxy", "-d"]

