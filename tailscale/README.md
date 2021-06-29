A tailscale Relay Server in docker

See https://tailscale.com/kb/1019/subnets/

---

Entrypoints:
- `entrypoint_relay.sh` Tailscale relay mode, authenticates and advertises the configured subnet routes.
- `entrypoint_client.sh` Tailscale client mode, authenticates and starts a userspace Socks5 proxy to route traffic into the Tailscale network.

---

Environment variables:

- `$HOSTNAME` machine name, visible in tailscale dashboard
- `$AUTHKEY` machine authentication key
- `$ROUTES` (`entrypoint_relay.sh` only) local subnet routes to advertise to the tailscale network.  Comma separated cidr format routes (e.g. 10.0.0.0/8,123.123.123.0/24)

---

Custom tailscale binaries (in `./bin/`) are built from source (https://github.com/tailscale/tailscale) and implement a minor patch to force all 10/8 traffic over tailscale to workaround issues with their current socks5 implementation.  An official solution to this is ongoing at https://github.com/tailscale/tailscale/issues/2268
