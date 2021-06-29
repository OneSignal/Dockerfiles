#!/bin/bash

while [ ! -S /app/tailscaled.sock ]; do echo "Waiting for tailscaled to startup..." && sleep 1; done
