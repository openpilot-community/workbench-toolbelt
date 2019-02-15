#!/bin/bash
set -e
 
printf "\n\033[0;44m---> Starting the SSH server.\033[0m\n"

service ssh start
service ssh status
/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{printf $1}'

exec "$@"