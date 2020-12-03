#!/bin/bash

set -e

version=$1

./deploy-single.sh "${version}"
./deploy-single.sh "${version}-ruby-capnp"
./deploy-single.sh "${version}-openssl-1.1"
