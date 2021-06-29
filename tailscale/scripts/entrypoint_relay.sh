#!/bin/bash

set -m

/app/scripts/_tailscaled.sh &
/app/scripts/_tailscaled_await.sh

tailscale --socket=/app/tailscaled.sock up \
          --reset \
          --accept-dns=true \
          --accept-routes=true \
          --accept-dns=false \
          --accept-routes=false \
          --snat-subnet-routes \
          --advertise-routes $ROUTES \
          --hostname $HOSTNAME \
          --authkey $AUTHKEY

function stop() {
    tailscale --socket=/app/tailscaled.sock down
    exit 0
}
trap stop SIGINT SIGTERM

fg
