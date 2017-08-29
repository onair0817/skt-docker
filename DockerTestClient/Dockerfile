FROM ubuntu:14.04

#Install git
RUN apt-get update && apt-get install -y git

#Install java
RUN \
	apt-get update && \
	apt-get install -y openjdk-7-jdk && \
	rm -rf /var/lib/apt/lists/*
#Install maven
RUN \
	apt-get update && \
	apt-get install -y maven

#Git clone from remote repository
RUN git clone https://github.com/lleejong/NS3Client.git   
WORKDIR /data

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

#Install NS3
RUN apt-get update
RUN apt-get install -y mercurial libexpat1-dev git-core build-essential bison flex libssl-dev libdb-dev libpcap-dev libc6-dbg libsysfs-dev gawk indent pkg-config autoconf automake

WORKDIR /var/lib/dce-linux-dev
# bake
RUN mkdir -p /var/lib/dce-linux-dev
RUN hg clone http://code.nsnam.org/bake

RUN ./bake/bake.py configure -e dce-linux-dev -e dce-umip-dev
RUN ./bake/bake.py download
RUN ./bake/bake.py build
RUN cd source/ns-3-dce && ./test.py

#download kupakupa
RUN cd /var/lib/dce-linux-dev/source/ns-3-dce/myscripts && git clone https://github.com/anetaaneta/kupakupa kupakupa
#RUN cd /var/lib/dce-linux-dev/ && git clone https://github.com/lleejong/NS3-DCE-Modified
RUN cp /var/lib/dce-linux-dev/source/ns-3-dce/myscripts/kupakupa/point-to-point-channel.* /var/lib/dce-linux-dev/source/ns-3-dev-dce/src/point-to-point/model/
#RUN cp /var/lib/dce-linux-dev/NS3-DCE-Modified/point-to-point-channel.* /var/lib/dce-linux-dev/source/ns-3-dev-dce/src/point-to-point/model/

RUN ./bake/bake.py build
RUN cd source/ns-3-dce && ./test.py

WORKDIR /
CMD ["/bin/bash"]
