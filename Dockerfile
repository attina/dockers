FROM fedora:latest

LABEL maintainer="attinagaoxu@gmail.com"

# RUN dnf -y update
RUN dnf -y install autoconf gperf bison file flex texinfo help2man gcc-c++ libtool make patch \
    ncurses-devel python3-devel perl-Thread-Queue bzip2 git wget which xz unzip gettext-devel
RUN dnf clean all

RUN useradd xtools
RUN usermod -a -G wheel xtools
RUN echo "xtools:xtools" | chpasswd

USER xtools
WORKDIR /home/xtools
RUN git clone --single-branch --depth 1 -b crosstool-ng-1.24.0 https://github.com/crosstool-ng/crosstool-ng
WORKDIR /home/xtools/crosstool-ng
COPY --chown=xtools:xtools arm-cortex_a8-linux-gnueabihf /home/xtools/crosstool-ng/build/samples/arm-cortex_a8-linux-gnueabihf
RUN ls 
RUN ./bootstrap
RUN ./configure
RUN make
USER root
RUN make install
USER xtools
WORKDIR /home/xtools/crosstool-ng/build
RUN ct-ng arm-cortex_a8-linux-gnueabihf
RUN ct-ng build
WORKDIR /home/xtools
RUN tar zcf x-tools-arm-cortex_a8-linux-gnueabihf.tar.gz x-tools
RUN upload-github-release-asset.sh github_api_token=c07dbac22ce41199641589e6e8037fed4571d718 owner=attina repo=xtools tag=1.24.0 filename=./x-tools-arm-cortex_a8-linux-gnueabihf.tar.gz
USER root
WORKDIR /home/xtools/crosstool-ng
RUN make uninstall
RUN rm -rf /home/xtools/crosstool-ng
