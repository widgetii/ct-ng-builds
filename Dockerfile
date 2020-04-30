FROM ubuntu:20.04

RUN apt-get update
# http://crosstool-ng.github.io/docs/os-setup/
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential automake bison chrpath flex g++ git gperf gawk libexpat1-dev libncurses5-dev libsdl1.2-dev libtool python2.7-dev texinfo rsync libtool-bin help2man unzip python python3-dev wget

RUN groupadd --gid 2000 build \
  && useradd --uid 2000 --gid build --shell /bin/bash --create-home build

USER build
WORKDIR /home/build

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

ARG BRANCH=master
ARG HASH_COMMIT=HEAD

RUN git clone --depth=1 --branch=${BRANCH} https://github.com/crosstool-ng/crosstool-ng
WORKDIR /home/build/crosstool-ng
RUN git checkout ${HASH_COMMIT}

RUN ./bootstrap
RUN ./configure --enable-local
RUN make
