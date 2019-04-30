#!/bin/bash

DIR=$(realpath "$(dirname ${0})") 

NETWORK=demo_default
DOCKER_FLAGS="--network=$NETWORK --env-file=$DIR/trees.env --volume=$DIR/pydevices:/pydevices"

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

function demo-shell() {
    NAME=$(demo-next-name shell)
    docker run --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) whobrokethebuild/mdsplus:latest sh "$@"
}

function demo-mdstcl() {
    NAME=$(demo-next-name mdstcl)
    docker run --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) whobrokethebuild/mdsplus:latest mdstcl "$@"
}

function demo-dwscope() {
    NAME=$(demo-next-name dwscope)
    docker run --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest dwscope "$@"
}

function demo-traverser() {
    NAME=$(demo-next-name traverser)
    docker run --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest traverser "$@"
}

function demo-actmon() {
    NAME=$(demo-next-name actmon)
    docker run --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest actmon "$@"
}