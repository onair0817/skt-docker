FROM ubuntu:14.04

#Install git
RUN apt-get update && apt-get install -y git

#Install java
RUN \
	apt-get update && \
	apt-get install -y openjdk-7-jdk && \
	rm -rf /var/lib/apt/lists/*
#Install Docker
RUN \
	apt-get update && \
	apt-get install -y curl && \
	curl -s https://get.docker.io/ubuntu/
WORKDIR /data

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

CMD ["bash"]


