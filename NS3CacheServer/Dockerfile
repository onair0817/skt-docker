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

# Install MySQL.
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
# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]


ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
CMD service mysql start && tail -F /var/log/mysql/error.log
CMD ["/bin/bash"]

#Git clone from remote repository
WORKDIR /
RUN git clone https://github.com/lleejong/NS3CacheServer.git
RUN cd /NS3CacheServer && mvn install && mvn compile && mvn package
RUN cd /NS3CacheServer/ && chmod 777 ./run.sh
RUN cd /NS3CacheServer/ && sed -i 's/\r$//' ./run.sh

#EXPOSE 3306


