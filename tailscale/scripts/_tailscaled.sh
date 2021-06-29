#!/bin/bash

tailscaled --state=/app/state/tailscaled.state \
           --socket=/app/tailscaled.sock \
           --tun userspace-networking \
           --socks5-server=127.0.0.1:1055
