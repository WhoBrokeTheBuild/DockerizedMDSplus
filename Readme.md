# Dockerized MDSplus

## Building

```shell
make
# or
make mdsplus
# or
make tree-server
# or
make mdsip-server
```

## Publishing

```shell
make push
```

## Demo

```shell
cd demo/
# Source helper functions
. ./setup.sh
# Start servers
UID=$(id -u) GID=$(id -g) docker-compose up -d
# Create model
demo-mdstcl """@/scripts/create_demo_tree.tcl"""
# Inspect/update model
demo-traverser -tree demo -shot -1
# Open actmon
demo-monitor
# Open scope, data file is mounted to /scopes/wave.dat
demo-dwscope
# Take a shot
demo-shot
# Finish a shot
demo-stop
```