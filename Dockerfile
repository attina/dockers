FROM fedora:latest

LABEL maintainer="attinagaoxu@gmail.com"

RUN dnf -y update && dnf clean all
RUN dnf -y install gcc g++ git make which unzip file patch wget cpio rsync bc bzip2 ncurses-devel perl-ExtUtils-MakeMaker perl-Thread-Queue
# RUN dnf -y install java-1.8.0-openjdk openssh-server qt5-devel qt5-qtbase-devel opencv-devel git && dnf clean all

# RUN dnf -y install hostname && dnf clean all

# RUN ssh-keygen -A
# RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

# RUN mkdir -p /var/run/sshd
RUN useradd sn335x
RUN usermod -a -G wheel sn335x
RUN echo "sn335x:sn335x" | chpasswd
RUN mkdir -p /home/sn335x && chown sn335x /home/sn335x

# EXPOSE 22

# CMD ["/usr/sbin/sshd", "-D"]

# CMD bash

USER sn335x
WORKDIR /home/sn335x
RUN git clone --single-branch --depth 1 -b 2019.11.x git://git.busybox.net/buildroot
RUN curl -o sn335x_buildroot_defconfig https://gist.githubusercontent.com/attina/1cf9d8eca6a102a356412ed284fb0e5c/raw/c40fad4cdd139b8dd2398761e8595d44e7637bcb/sn335x_buildroot_defconfig
RUN curl -o sn335x_linux_defconfig https://gist.githubusercontent.com/attina/1cf9d8eca6a102a356412ed284fb0e5c/raw/10d9cc5c49b5f82c7212b88389b09831ef130062/sn335x_linux_defconfig
RUN curl -o sn335x-ppu.dts https://gist.githubusercontent.com/attina/1cf9d8eca6a102a356412ed284fb0e5c/raw/10d9cc5c49b5f82c7212b88389b09831ef130062/sn335x-ppu.dts
RUN cp sn335x_buildroot_defconfig buildroot/configs/sn335x_defconfig
WORKDIR /home/sn335x/buildroot
RUN make sn335x_defconfig
RUN make all; exit 0
