A tailscale Relay Server in docker

See https://tailscale.com/kb/1019/subnets/

---

Environment variables:

- `$HOSTNAME` machine name, visible in tailscale dashboard
- `$ROUTES` local subnet routes to advertise to the tailscale network.  Comma separated cidr format routes (e.g. 10.0.0.0/8,123.123.123.0/24)
- `$AUTHKEY` machine authentication key
