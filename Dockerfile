FROM fedora:latest

LABEL maintainer="attinagaoxu@gmail.com"

RUN dnf -y update && dnf clean all
RUN dnf -y install java-1.8.0-openjdk openssh-server qt5-devel qt5-qtbase-devel opencv-devel git && dnf clean all

RUN dnf -y install hostname && dnf clean all

RUN ssh-keygen -A
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd

RUN mkdir -p /var/run/sshd
RUN useradd jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN mkdir -p /home/jenkins && chown jenkins /home/jenkins

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

