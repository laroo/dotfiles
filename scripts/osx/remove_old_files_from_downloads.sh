#!/usr/local/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "Starting to remove old files"

find /Users/laroo/Downloads -ctime +30 -print0 | xargs -0 rm -r

echo "Done"
