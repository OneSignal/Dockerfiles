FROM debian:10.9

RUN mkdir -p /app/
RUN mkdir -p /app/state/
RUN mkdir -p /app/scripts/
WORKDIR /app/

RUN apt-get update -y && \
    apt-get install -y curl gpg && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/buster.gpg | apt-key add - && \
    curl -fsSL https://pkgs.tailscale.com/stable/debian/buster.list | tee /etc/apt/sources.list.d/tailscale.list && \
    apt-get update -y && \
    apt-get install --no-install-recommends -y tailscale=1.8.7 python3-pip=18.1-5

COPY ./scripts/requirements.txt /app/scripts/requirements.txt
RUN pip3 install -r /app/scripts/requirements.txt

COPY ./scripts/ /app/scripts/

COPY ./bin/tailscale /usr/bin/tailscale
COPY ./bin/tailscaled /usr/sbin/tailscaled

# Security policy complains if we have a non-numeric user (runAsNonRoot checks)
RUN useradd -d /app/ -s /bin/false -g nogroup -M -N -u 1000 tailscale
RUN chown -R tailscale /app/
USER 1000
