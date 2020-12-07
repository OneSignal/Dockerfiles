# This is the basic runtime image that our Rust services need. It contains a
# base ubuntu image and openssl.
#
# This is the minimal ubuntu image
FROM ubuntu:20:04

# We require openssl installed on the container
RUN apt-get update && apt-get install -y \
    libssl1.0.0 \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
