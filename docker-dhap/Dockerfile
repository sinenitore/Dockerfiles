FROM ubuntu:12.10
MAINTAINER thisguy@here.net

RUN sudo apt-get update && sudo apt-get install -y python-dev \
	&& sudo apt-get install -y python-flask python-pip
RUN sudo pip install python-etcd

EXPOSE 5000

