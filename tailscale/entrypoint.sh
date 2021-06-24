#!/bin/bash

set -m

tailscaled --state=/app/state/tailscaled.state \
           --socket=/app/tailscaled.sock \
           --tun userspace-networking &

while [ ! -S /app/tailscaled.sock ]; do echo "Waiting for tailscaled to startup..." && sleep 1; done

tailscale --socket=/app/tailscaled.sock up \
          --reset \
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
