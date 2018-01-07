FROM ubuntu:latest
MAINTAINER raisercostin "raisercostin@gmail.com"

ENV TERM=xterm

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        iproute2 \
        telnet \
        inetutils-ping \
        net-tools \
        zip \
        unzip \
        mc \
        openjdk-8-jdk-headless

#ADD jars/ /jars/

COPY run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 8280
CMD ["/run.sh"]
