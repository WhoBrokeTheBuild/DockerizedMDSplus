#!/bin/bash

DIR=$(realpath "$(dirname ${0})") 

NETWORK=demo_default
DOCKER_FLAGS="--network=$NETWORK --env-file=$DIR/trees.env --env-file=$DIR/servers.env --volume=$DIR/scripts:/scripts --volume=$DIR/pydevices:/pydevices"

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
    docker run -d --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) -v $DIR/scopes:/scopes --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest dwscope "$@"
}

function demo-traverser() {
    NAME=$(demo-next-name traverser)
    docker run -d --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest traverser "$@"
}

function demo-actmon() {
    NAME=$(demo-next-name actmon)
    docker run -d --name="$NAME" --rm -it $(echo $DOCKER_FLAGS) --env=DISPLAY --env=QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw whobrokethebuild/mdsplus:latest actmon "$@"
}

function demo-monitor() {
    demo-actmon -tree demo -monitor event:demo_actmon
}

function demo-shot() {
    demo-mdstcl dispatch /command /server=dispatch_server:8101 """@/scripts/shot.tcl"""
}

function demo-stop() {
    demo-mdstcl dispatch /command /server=dispatch_server:8101 """@/scripts/stop.tcl"""
}