FROM alpine:latest

WORKDIR /opt/vlang

ENV AUTHOR "Alistair Smith hi@alistair.sh"

ENV VVV  /opt/vlang
ENV PATH /opt/vlang:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV VFLAGS -cc gcc

RUN mkdir -p /opt/vlang && ln -s /opt/vlang/v /usr/bin/v

ARG USE_LOCAL

RUN apk --no-cache add \
  git make gcc bash \
  musl-dev libc-dev \
  openssl-dev sqlite-dev \
  libx11-dev glfw-dev freetype-dev \
  libc6-compat gcompat binutils

COPY . /vlang-local

RUN if [[ -z "${USE_LOCAL}" ]] ; then \
      git clone https://github.com/vlang/v/ /opt/vlang && \
      rm -rf /vlang-local ; \
    else \
      mv /vlang-local/* . && \
      rm -rf /vlang-local ; \
    fi

RUN make && v -version
