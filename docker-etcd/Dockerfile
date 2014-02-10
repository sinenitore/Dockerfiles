FROM sine/go
RUN apt-get update
RUN apt-get install -y python-software-properties git curl
RUN curl -s https://go.googlecode.com/files/go1.2.src.tar.gz | tar -v -C /usr/local -xz
RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1
ENV PATH /usr/local/go/bin:$PATH
WORKDIR /opt
RUN git clone https://github.com/coreos/etcd
RUN cd etcd && ./build
ENV ETCD_BIND_ADDR 0.0.0.0:4001
ENV ETCD_PEER_BIND_ADDR 0.0.0.0:7001
EXPOSE 4001 7001
ENTRYPOINT ["/opt/etcd/bin/etcd"]
