FROM centos:centos8

# Check new releases at: https://github.com/pritunl/pritunl/releases
ENV VERSION="1.29.2664.67"

CMD ["pritunl", "start"]

COPY pritunl.repo /etc/yum.repos.d/pritunl.repo

RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A && \
    gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A > key.tmp && \
    rpm --import key.tmp; rm -f key.tmp && \
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    yum -y install "pritunl-$VERSION"
