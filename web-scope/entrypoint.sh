#!/bin/sh
set -e

. /etc/profile.d/mdsplus.sh

# Apache gets grumpy about PID files pre-existing
rm -f /usr/local/apache2/logs/httpd.pid

mkdir /run/apache2
exec httpd -DFOREGROUND