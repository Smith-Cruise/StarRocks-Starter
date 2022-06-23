FROM centos:centos7

ENV STARROCKS_VERSION 2.2.1

# Prepare StarRocks Installer.
RUN yum -y install wget
RUN mkdir -p /data/deploy/
RUN wget -O /data/deploy/StarRocks-${STARROCKS_VERSION}.tar.gz https://download.starrocks.com/zh-CN/download/request-download/30/StarRocks-${STARROCKS_VERSION}.tar.gz
RUN cd /data/deploy/ && tar zxf StarRocks-${STARROCKS_VERSION}.tar.gz

# Install Java JDK.
RUN yum -y install java-1.8.0-openjdk-devel.x86_64 

# Create directory for FE meta and BE storage in StarRocks.
RUN mkdir -p /data/deploy/StarRocks-${STARROCKS_VERSION}/fe/meta
RUN mkdir -p /data/deploy/StarRocks-${STARROCKS_VERSION}/be/storage

# Install relevant tools.
RUN yum -y install mysql net-tools telnet

# Run Setup script.
COPY run_script.sh /data/deploy/run_script.sh
RUN chmod +x /data/deploy/run_script.sh
CMD /data/deploy/run_script.sh