#!/bin/bash

set -m

/app/scripts/_tailscaled.sh &
/app/scripts/_tailscaled_await.sh

tailscale --socket=/app/tailscaled.sock up \
          --reset \
          --shields-up \
          --accept-dns=true \
          --accept-routes=true \
          --hostname $HOSTNAME \
          --authkey $AUTHKEY

while : ; do
    echo "Waiting for tailscale network to connect..."
    sleep 5
    ! timeout 5 bash -c 'cat < /dev/null > /dev/tcp/127.0.0.1/1055' || break
done
