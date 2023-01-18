FROM centos:centos7

ENV STARROCKS_VERSION 2.5.0-rc03

# Install relevant tools.
RUN yum -y install wget mysql net-tools telnet

# Prepare StarRocks Installer.
RUN mkdir -p /data/deploy/
RUN wget -O /data/deploy/StarRocks-${STARROCKS_VERSION}.tar.gz https://releases.starrocks.io/starrocks/StarRocks-${STARROCKS_VERSION}.tar.gz
RUN cd /data/deploy/ && tar zxf StarRocks-${STARROCKS_VERSION}.tar.gz && rm StarRocks-${STARROCKS_VERSION}.tar.gz

# Install Java JDK.
RUN yum -y install java-1.8.0-openjdk-devel.x86_64 

# Create directory for FE meta and BE storage in StarRocks.
RUN mkdir -p /data/deploy/StarRocks-${STARROCKS_VERSION}/fe/meta && mkdir -p /data/deploy/StarRocks-${STARROCKS_VERSION}/be/storage

# Run Setup script.
COPY run_script.sh /data/deploy/run_script.sh
RUN chmod +x /data/deploy/run_script.sh
CMD /data/deploy/run_script.sh
