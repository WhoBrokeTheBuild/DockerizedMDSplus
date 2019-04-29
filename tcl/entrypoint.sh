#!/bin/sh
set -e

export ${TREE}_path=${TREE_SERVER}::

. /etc/profile.d/mdsplus.sh

/usr/local/mdsplus/bin/mdstcl $@