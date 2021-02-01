#!/usr/bin/env bash
currentfolder=${PWD##*/}
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR || exit
docker build -t base2004 -f ./config/base2004.Dockerfile .
docker build --no-cache -t pyenv -f ./config/pyenv.Dockerfile  . && \
#docker build -t pyenv -f ./config/pyenv.Dockerfile  . && \
docker build -t $currentfolder -f ./config/jpl_config.Dockerfile . && \
#docker run -ti -v ${PWD}:/usr/local/bin/jpl_config -p 8888:8888 jpl_config
docker run -ti -v ${PWD}:/root -p 8888:8888 $currentfolder