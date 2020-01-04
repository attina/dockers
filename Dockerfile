FROM fedora:latest

LABEL maintainer="attinagaoxu@gmail.com"

RUN dnf -y update && dnf clean all
RUN dnf -y install gcc g++ git make which unzip file patch wget cpio rsync bc bzip2 ncurses-devel openssl-devel hostname perl-ExtUtils-MakeMaker perl-Thread-Queue
# RUN dnf -y install java-1.8.0-openjdk openssh-server qt5-devel qt5-qtbase-devel opencv-devel git && dnf clean all

# RUN dnf -y install hostname && dnf clean all

# RUN ssh-keygen -A
# RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

# RUN mkdir -p /var/run/sshd
RUN useradd ctng
RUN usermod -a -G wheel ctng
RUN echo "ctng:ctng" | chpasswd

# EXPOSE 22

# CMD ["/usr/sbin/sshd", "-D"]

# CMD bash

USER ctng
WORKDIR /home/ctng
RUN git clone --single-branch --depth 1 -b crosstool-ng-1.24.0 https://github.com/crosstool-ng/crosstool-ng
WORKDIR /home/ctng/crosstool-ng
RUN ./bootstrap
RUN ./configure
RUN make
USER root
RUN make install
USER ctng
RUN mkdir build
WORKDIR /home/ctng/crosstool-ng/build
COPY arm-cortex_a8-linux-gnueabihf /home/ctng/crosstool-ng/build/samples
RUN ct-ng arm-cortex_a8-linux-gnueabihf
RUN ct-ng build
WORKDIR /home/ctng
RUN tar zcf x-tools-arm-cortex_a8-linux-gnueabihf.tar.gz x-tools
RUN upload-github-release-asset.sh github_api_token=c07dbac22ce41199641589e6e8037fed4571d718 owner=attina repo=dockers tag=1.24.0 filename=./x-tools-arm-cortex_a8-linux-gnueabihf.tar.gz
RUN rm -rf /home/ctng/crosstool-ng/build