FROM fedora:latest

LABEL maintainer="attinagaoxu@gmail.com"

RUN dnf install qt5-devel -y

CMD bash

