# Adapted from Elle.ws documentation - https://sourceforge.net/projects/elle/files/elle/
FROM ubuntu:16.04

RUN useradd -m -u 1000 user

RUN apt-get update \
      && apt-get install -y --no-install-recommends software-properties-common \
      && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
      && apt-get install -y gfortran

RUN apt-get install -y xutils build-essential xutils-dev libx11-dev libxt-dev libmotif-dev libxpm-dev
RUN apt-get install -y x11proto-print-dev x11proto-xext-dev libxext-dev
RUN apt-get install -y libgsl2
RUN apt-get install -y libgsl-dev
RUN apt-get install -y libgtk2.0-dev

# Complete

RUN apt-get install wget

RUN mkdir -p /home/user/downloads && cd /home/user/downloads && wget https://sourceforge.net/projects/wxwindows/files/2.8.12/wxGTK-2.8.12.tar.gz && cd /usr/local && tar xvzf /home/user/downloads/wxGTK-2.8.12.tar.gz && cd wxGTK-2.8.12 && mkdir buildgtk && cd buildgtk && ../configure --with-gtk && make && make install && ldconfig

RUN cd /home/user && wget https://sourceforge.net/projects/elle/files/elle/elle-2.7.1rel.tar.gz && tar xvzf elle-2.7.1rel.tar.gz

RUN mv elle elle-2.7.1 && cd elle-2.7.1/elle && ./install.sh wx

# Documentation has this the other way around
RUN ln -s /home/user/elle-2.7.1/elle /usr/local/elle

RUN touch /home/user/.bash_profile

RUN echo 'export PATH=$PATH:/home/user/elle-2.7.1/elle/binwx' >>  /home/user/.bash_profile
RUN echo 'export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib' >>  /home/user/.bash_profile
RUN echo 'ELLEPATH=/home/user/elle-2.7.1/elle/binwx' >>  /home/user/.bash_profile
RUN echo 'export PATH LD_LIBRARY_PATH ELLEPATH' >>  /home/user/.bash_profile

# Set root password to 'toor'
RUN echo 'root:toor' | chpasswd
