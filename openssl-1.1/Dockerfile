FROM osig/rust-ubuntu:1.27.0

RUN apt-get update && apt-get install -y unzip
RUN \
    wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_0-stable.zip && \
    unzip OpenSSL_1_1_0-stable.zip && cd openssl-OpenSSL_1_1_0-stable && \
    ./config && make -j $(nproc) && make install
ENV LD_LIBRARY_PATH /usr/local/lib
