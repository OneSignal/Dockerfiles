#!/usr/bin/env bash

# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# -e => Exit on error instead of continuing
set -e

# Should not require user input if already logged in
docker login

# `sort -r` => reverse sort so that 1.27.0 goes before 1.27.0-*
# `sed 's|/||'` => remove trailing /
for DIR in `/bin/ls -d */ | sort -r | sed 's|/||'`
do
  echo "DIR: $DIR"
  pushd $DIR

  IMAGE="osig/rust-ubuntu:$DIR"

  docker build -t $IMAGE .
  docker push $IMAGE

  popd
done
