#!/usr/bin/env bash
basepath=${PWD}/config
docker build -t base2004 -f $basepath/base2004.Dockerfile .
docker build -t pyenv -f $basepath/pyenv.Dockerfile . && \
docker build -t jpl_config -f $basepath/jpl_config.Dockerfile . && \
docker run -ti -v ${PWD}:/usr/local/bin/jpl_config -p 8888:8888 jpl_config