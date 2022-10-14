FROM debian

WORKDIR /opt/vlang

ENV AUTHOR "Alistair Smith hi@alistair.sh"

ENV VVV  /opt/vlang
ENV PATH /opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV VFLAGS -cc gcc

RUN mkdir -p /opt/vlang && ln -s /opt/vlang/v /usr/bin/v

RUN apt update
RUN apt install -y git make gcc bash musl-dev libc-dev libx11-dev

RUN git clone https://github.com/vlang/v /opt/vlang

RUN make && v -version
