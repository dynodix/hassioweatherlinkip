ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.3.1
FROM ${BUILD_FROM}
#ARG BUILD_FROM
#FROM $BUILD_FROM
#FROM debian:buster
#FROM homeassistant/amd64-base-debian

# Set shell
#SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install requirements for add-on
#RUN set -x
RUN apt-get update 
RUN apt-get install -y --no-install-recommends \
       perl \
       libmojolicious-perl \
       libipc-system-simple-perl \
       make \
       wget \
       libextutils-makemaker-cpanfile-perl \
       libdevice-serialport-perl \
       git 

#RUN cd /var 
RUN git config --global http.sslverify false
RUN git clone https://github.com/pjsg/Device-VantagePro.git
RUN cd /Device-VantagePro/ && perl Makefile.PL 
RUN cd /Device-VantagePro/ && make 
RUN cd /Device-VantagePro/ && make install
#  apk add --no-cache \
#    apt
#    perl libmojolicious-perl libipc-system-simple-perl 

# Copy data for add-on
COPY runc.sh /
COPY weatherserver.pl /
RUN chmod a+x /runc.sh

CMD [ "/runc.sh" ]
