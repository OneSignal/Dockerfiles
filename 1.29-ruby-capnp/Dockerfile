FROM osig/rust-ubuntu:1.29

ENV ONESIGNAL_CAPNPROTO_RELEASE_URL="https://github.com/OneSignal/capnproto-debian/releases/download/onesignal-0.6.1-1" \
  ONESIGNAL_CAPNPROTO_DEB="capnproto_0.6.1-1_amd64.deb" \
  ONESIGNAL_LIBCAPNP_DEB="libcapnp-0.6.1_0.6.1-1_amd64.deb" \
  ONESIGNAL_LIBCAPNP_DEV_DEB="libcapnp-dev_0.6.1-1_amd64.deb"

RUN set -ex \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
  git curl lftp zsh vim postgresql-client cmake ssh \
  && cd /tmp \
  && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_CAPNPROTO_DEB}" \
  && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEB}" \
  && curl -sSLO "${ONESIGNAL_CAPNPROTO_RELEASE_URL}/${ONESIGNAL_LIBCAPNP_DEV_DEB}" \
  && dpkg -i "${ONESIGNAL_CAPNPROTO_DEB}" "${ONESIGNAL_LIBCAPNP_DEB}" "${ONESIGNAL_LIBCAPNP_DEV_DEB}"\
  && git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  && export PATH="$HOME/.rbenv/bin:$PATH" \
  && mkdir -p "$(rbenv root)"/plugins \
  && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build\
  && eval "$(rbenv init -)" \
  && rbenv install 2.4.4 \
  && rbenv global 2.4.4 \
  && gem install thermite \
  && gem install bundler
