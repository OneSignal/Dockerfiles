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

RUN set -eux; \
  \
  # this "case" statement is generated via "update.sh"
  dpkgArch="$(dpkg --print-architecture)"; \
  case "${dpkgArch##*-}" in \
  amd64) rustArch='x86_64-unknown-linux-gnu'; rustupSha256='a46fe67199b7bcbbde2dcbc23ae08db6f29883e260e23899a88b9073effc9076' ;; \
  *) echo >&2 "unsupported architecture: ${dpkgArch}"; exit 1 ;; \
  esac; \
  \
  url="https://static.rust-lang.org/rustup/archive/1.18.3/${rustArch}/rustup-init"; \
  wget "$url"; \
  echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
  chmod +x rustup-init; \
  ./rustup-init -y --no-modify-path --default-toolchain 1.46.0; \
  rm rustup-init; \
  chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
  rustup --version; \
  cargo --version; \
  rustc --version; \
  rustup component add rls-preview rust-src rust-analysis rustfmt-preview
