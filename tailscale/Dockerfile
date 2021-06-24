FROM debian:10.9

RUN mkdir -p /app/
RUN mkdir -p /app/.cache/
RUN mkdir -p /app/state/
WORKDIR /app/

RUN apt-get update -y && \
    apt-get install -y curl gpg && \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | apt-key add - && \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | tee /etc/apt/sources.list.d/tailscale.list && \
    apt-get update -y && \
    apt-get install -y tailscale=1.8.7

COPY ./entrypoint.sh /app/entrypoint.sh

# Security policy complains if we have a non-numeric user (runAsNonRoot checks)
RUN useradd -d /app/ -s /bin/false -g nogroup -M -N -u 1000 tailscale
RUN chown -R tailscale /app/
USER 1000

CMD ["bash", "-c", "/app/entrypoint.sh"]
