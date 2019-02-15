#!/bin/bash
set -e
 
printf "\n\033[0;44mWorkbench Toolbelt is starting up...\033[0m\n"

service ssh start
service ssh status

printf "\n\033[0;44mWill start other services here soon...\033[0m\n"

exec "$@"