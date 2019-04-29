#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

NETWORK=demo_default
ENV_FILE=$DIR/default.env

xhost +local:root

function demo-next-name() {
    BASE=$1
    INDEX=1
    while : ; do
        NAME="demo_$BASE""_$INDEX"
        docker inspect $NAME >/dev/null 2>&1
        if [[ "$?" == 1 ]]; then
            echo $NAME
            break
        fi
        INDEX=$((INDEX + 1))
    done
}

function demo-mdstcl() {
    NAME=$(demo-next-name mdstcl)
    docker run --name=$NAME --rm -it --env-file=$ENV_FILE --network=$NETWORK whobrokethebuild/mdsplus:latest mdstcl $@
}

function demo-dwscope() {
    NAME=$(demo-next-name dwscope)
    docker run --name=$NAME --rm -it --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --env-file=$ENV_FILE --network=$NETWORK --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest dwscope $@
}

function demo-traverser() {
    NAME=$(demo-next-name traverser)
    docker run --name=$NAME --rm -it --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --env-file=$ENV_FILE --network=$NETWORK --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest traverser $@
}

function demo-actmon() {
    NAME=$(demo-next-name actmon)
    docker run --name=$NAME --rm -it --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --env-file=$ENV_FILE --network=$NETWORK --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest actmon $@
}