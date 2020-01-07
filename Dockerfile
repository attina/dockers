FROM fedora:latest

LABEL maintainer="attinagaoxu@gmail.com"

RUN dnf -y update
RUN dnf -y install gcc g++ git make which unzip file patch wget cpio rsync bc bzip2 ncurses-devel \
openssl-devel hostname perl-ExtUtils-MakeMaker perl-Thread-Queue
RUN dnf clean all

RUN useradd xtools
RUN usermod -a -G wheel xtools
RUN echo "xtools:xtools" | chpasswd
RUN mkdir -p /home/xtools && chown xtools /home/xtools

USER xtools
WORKDIR /home/xtools
RUN git clone --single-branch --depth 1 -b 2019.11.x https://github.com/buildroot/buildroot.git
RUN mkdir -p sn335x
COPY --chown=xtools:xtools sn335x /home/xtools/sn335x
WORKDIR /home/xtools/sn335x
RUN chmod +x patch-buildroot.sh
RUN ./patch-buildroot.sh /home/xtools/buildroot
WORKDIR /home/xtools/buildroot
RUN make sn335x_defconfig
RUN make source; exit 0
