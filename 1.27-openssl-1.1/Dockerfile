FROM osig/rust-ubuntu:1.27

# Cannot use OneSignal/openssl pre-built binary since it needs header files as well.
RUN \
    wget https://github.com/openssl/openssl/archive/OpenSSL_1_1_0-stable.zip && \
    unzip OpenSSL_1_1_0-stable.zip && cd openssl-OpenSSL_1_1_0-stable && \
    ./config && make -j $(nproc) && make install
ENV LD_LIBRARY_PATH /usr/local/lib
