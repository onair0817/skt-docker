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

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config
VOLUME ["/etc/mysql", "/var/lib/mysql"]


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

RUN ./bake/bake.py configure -e dce-linux-1.7
RUN ./bake/bake.py download
RUN ./bake/bake.py build
RUN cd source/ns-3-dce
#download kupakupa
RUN cd /var/lib/dce-linux-dev/source/ns-3-dce/myscripts && git clone https://github.com/anetaaneta/kupakupa kupakupa
RUN cd /var/lib/dce-linux-dev/ && git clone https://github.com/lleejong/NS3-DCE-Modified
RUN cp /var/lib/dce-linux-dev/source/ns-3-dce/myscripts/kupakupa/point-to-point-channel.* /var/lib/dce-linux-dev/source/ns-3.24/src/point-to-point/model/
RUN cp /var/lib/dce-linux-dev/NS3-DCE-Modified/point-to-point-channel.* /var/lib/dce-linux-dev/source/ns-3.24/src/point-to-point/model/

RUN ./bake/bake.py build
RUN cd source/ns-3-dce && ./test.py

#modified DCE install

#RUN ./bake/bake.py build
#RUN cd source/ns-3-dce && ./test.py

#RUN apt-get -y install gcc g++ python python-dev mercurial bzr gdb valgrind gsl-bin libgsl0-dev libgsl0ldbl flex bison tcpdump sqlite sqlite3 libsqlite3-dev libxml2 libxml2-dev libgtk2.0-0 libgtk2.0-dev uncrustify doxygen graphviz imagemagick texlive texlive-latex-extra texlive-generic-extra texlive-generic-recommended texinfo dia texlive texlive-latex-extra texlive-extra-utils texlive-generic-recommended texi2html python-pygraphviz python-kiwi python-pygoocanvas libgoocanvas-dev python-pygccxml

#NS3 mercurial
#RUN cd && mkdir repos && cd repos &&  hg clone http://code.nsnam.org/ns-3-allinone
#RUN cd && cd repos/ns-3-allinone && ./download.py -n ns-3-dev
#RUN cd && cd repos/ns-3-allinone/ns-3-dev && ./waf configure && ./waf  

CMD ["bash"]
