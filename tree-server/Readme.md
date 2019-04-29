
# MDSplus Tree Server

## Build Arguments

* `MDSPLUS_FLAVOR` can be set to either `alpha` or `stable` to control the flavor of packages installed.

## Ports

* Port `8000` is exposed for accessing the mdsip server.

## Environment Variables

* `TREE` should be set to the name of your tree, it will create the environment variable `$TREE_path=/data`.

## Volumes

* `/data` should be mounted to the directory your tree files are in.

* `/logs` can be mounted in order to retrieve runtime logs from the server.

