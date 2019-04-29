#!/bin/bash
set -e

. /etc/profile.d/mdsplus.sh

echo "Adding hostuser $UID:$GID"
addgroup -g $GID hostgroup
adduser -D -u $UID -G hostgroup hostuser

inetd -fe