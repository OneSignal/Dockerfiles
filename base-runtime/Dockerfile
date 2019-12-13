# The first build step here will build the envoy-preflight binary so that it
# can be included in our base image. envoy-preflight is used to ensure that
# envoy has started up before our app starts.
FROM golang

RUN go get github.com/monzo/envoy-preflight

# This is the basic runtime image that our Rust services need. It contains a
# base ubuntu image and openssl.
#
# This is the minimal ubuntu image
FROM ubuntu:18.04

COPY --from=0 /go/bin/envoy-preflight /usr/bin/

# The entrypoint should not be overridden by app images, the path to the app
# executable should be provided as an image argument.
ENTRYPOINT [ "/usr/bin/envoy-preflight" ]

# We require openssl installed on the container
RUN apt-get update && apt-get install -y \
    libssl1.0.0 \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*
