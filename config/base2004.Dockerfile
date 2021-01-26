FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y --fix-missing build-essential  \
     checkinstall \
     libreadline-gplv2-dev \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    zlib1g-dev \
    openssl \
    libffi-dev \
    python3-dev \
    python3-setuptools \
    wget \
    curl
    #nodejs \
    #npm

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash -
RUN apt install -y nodejs


RUN mkdir /tmp/Python39 \
    && cd /tmp/Python39 \
    && wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tar.xz \
    && tar xvf Python-3.9.0.tar.xz \
    && cd /tmp/Python39/Python-3.9.0 \
    && ./configure \
    && make altinstall

RUN ln -s /usr/local/bin/python3.9 /usr/bin/python
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

RUN pip install --upgrade pip
RUN pip install requests
RUN apt-get install curl -y

RUN pip install jupyter --upgrade
RUN pip install jupyterlab --upgrade
RUN jupyter labextension install @jupyterlab/toc

RUN apt-get install pandoc -y
RUN apt-get install texlive-xetex -y 

RUN unlink /usr/bin/python
RUN ln -s /usr/local/bin/python3.9 /usr/bin/python

RUN apt-get install bash -y
RUN pip install bash_kernel
RUN python -m bash_kernel.install


RUN apt install git-all -y
RUN apt install nano -y 
RUN apt install htop -y

# ZSH
RUN apt-get install zsh -y
RUN chsh -s /bin/zsh
RUN sh -c $(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)

RUN sh -c $(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)
# install zinit plugins (fzf)

# PULL dotfiles to set up zsh and its plugins
RUN wget -q https://github.com/cdr/code-server/releases/download/v3.8.0/code-server_3.8.0_arm64.deb
RUN dpkg -i code-server_3.8.0_arm64.deb

# put this to run or entry point

# user must be created for this
#RUN systemctl --user start code-server \
#  && systemctl --user enable code-server

# VSCODE

## VSCODE SERVER and extensions from list

# GIT AND SSH KEY
# COPY github, gitlab ... keys
# create ssh-keypair prompt