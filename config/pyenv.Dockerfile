FROM base2004
RUN echo "The base path is: \n"
RUN echo $basepath
# RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
# RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc \
#     echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc \
#     echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n eval "$(pyenv init -)"\nfi' >> ~/.bashrc


# #ENV HOME  /home/python_user
# ENV PYENV_ROOT ~/.pyenv
# ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# RUN pyenv install 2.7.12
# RUN pyenv install pypy3.6-7.3.1 

#CFLAGS="-I/usr/include/openssl"
#LDFLAGS="-L/usr/lib/openssl-1.0"

# set the variables as per $(pyenv init -)
ENV LANG="C.UTF-8" \
    LC_ALL="C.UTF-8" \
    PATH="/opt/pyenv/shims:/opt/pyenv/bin:$PATH" \
    PYENV_ROOT="/opt/pyenv" \
    PYENV_SHELL="bash"

RUN apt-get install aptitude -y
RUN aptitude update
RUN aptitude upgrade -y

#RUN apt install -y --no-install-recommends \
# install cmake
# wget https://github.com/Kitware/CMake/releases/download/v3.19.3/cmake-3.19.3.tar.gz
# tar -zxvf cmake-3.19.3.tar.gz
# cd cmake-3.19.3
# ./bootstrap
# make install
# cmake --version
# compile bzip2
# cd bzip2
#mkdir build && cd build
#cmake ..
#cmake --build . --config Release
# ln -s /~/bzip2/build/bzip2 /usr/bin/bzip2

#openssl
#https://cloudwafer.com/blog/installing-openssl-on-ubuntu-16-04-18-04/
#aptitude update && aptitude upgrade
#aptitude install build-essential checkinstall zlib1g-dev -y
#

RUN apt install -y  \
        build-essential \
        ca-certificates \
 #       curl \
        git \
        libbz2-dev \
        libffi-dev \
        libncurses5-dev \
        libncursesw5-dev \
        libreadline-dev \
        libedit-dev \
        libsqlite3-dev \
        #libssl1.0-dev \
        liblzma-dev \
        # libssl-dev \
        llvm \
        make \
        netbase \
        pkg-config \
        python-openssl \
        #OpenSSL 1.1.1f  31 Mar 2020
        tk-dev \
        wget \
        xz-utils \
        zlib1g-dev \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#COPY $basepath/pyenv-version.txt ./ \
#    $basepath/python-versions.txt /
COPY ./config/pyenv-version.txt ./ \
     ./config/python-versions.txt ./

RUN git clone -b `cat /pyenv-version.txt` --single-branch --depth 1 https://github.com/pyenv/pyenv.git $PYENV_ROOT \
    && for version in `cat /python-versions.txt`; do pyenv install $version; done \
    && pyenv global `cat /python-versions.txt` \
    && find $PYENV_ROOT/versions -type d '(' -name '__pycache__' -o -name 'test' -o -name 'tests' ')' -exec rm -rf '{}' + \
    && find $PYENV_ROOT/versions -type f '(' -name '*.pyo' -o -name '*.exe' ')' -exec rm -f '{}' + \
 && rm -rf /tmp/*

# TODO: make this for py2 and py3 and pypy, e.g.
# pypy3 -m pip install numpy
# COPY requirements-setup.txt requirements-test.txt requirements-ci.txt /
# RUN pip install -r /requirements-setup.txt \
#     && pip install -r /requirements-test.txt \
#     && pip install -r /requirements-ci.txt \
#     && find $PYENV_ROOT/versions -type d '(' -name '__pycache__' -o -name 'test' -o -name 'tests' ')' -exec rm -rf '{}' + \
#     && find $PYENV_ROOT/versions -type f '(' -name '*.pyo' -o -name '*.exe' ')' -exec rm -f '{}' + \
#  && rm -rf /tmp/*

# TODO make this generic for all installed python versions
RUN pyenv local pypy3.6-7.3.1 \
    && pypy3 -m pip install ipykernel \
    && pypy3 -m ipykernel install --user --name pypy3 --display-name "PyPy3"