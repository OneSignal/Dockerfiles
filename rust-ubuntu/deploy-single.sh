#!/usr/bin/env bash

# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
# -e => Exit on error instead of continuing
set -e

# Should not require user input if already logged in
docker login

echo "DIR: $1"
pushd $1

IMAGE="osig/rust-ubuntu:$1"

docker build -t $IMAGE .
docker push $IMAGE

popd
