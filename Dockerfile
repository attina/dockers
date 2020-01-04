FROM fedora:latest

LABEL maintainer="attinagaoxu@gmail.com"

RUN dnf -y update && dnf clean all
RUN dnf -y install gcc g++ git make which unzip file patch wget cpio rsync bc bzip2 ncurses-devel openssl-devel hostname perl-ExtUtils-MakeMaker perl-Thread-Queue
# RUN dnf -y install java-1.8.0-openjdk openssh-server qt5-devel qt5-qtbase-devel opencv-devel git && dnf clean all

# RUN dnf -y install hostname && dnf clean all

# RUN ssh-keygen -A
# RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

# RUN mkdir -p /var/run/sshd
RUN useradd am335x
RUN usermod -a -G wheel am335x
RUN echo "am335x:am335x" | chpasswd

# EXPOSE 22

# CMD ["/usr/sbin/sshd", "-D"]

# CMD bash

USER am335x
WORKDIR /home/am335x
RUN git clone --single-branch --depth 1 -b 2019.11.x git://git.busybox.net/buildroot
WORKDIR /home/am335x/buildroot
RUN make beaglebone_defconfig
RUN make sdk
