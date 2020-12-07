FROM redis:4.0.9

RUN apt-get update && apt-get install -y curl \
    && mkdir -p /opt/redis/lib/redis-cell \
    && curl -Lo /tmp/redis-cell.tar.gz https://github.com/brandur/redis-cell/releases/download/v0.2.5/redis-cell-v0.2.5-x86_64-unknown-linux-gnu.tar.gz \
    && tar xf /tmp/redis-cell.tar.gz \
    && mv libredis_cell.so /opt/redis/lib/redis-cell

COPY redis.conf /usr/local/etc/redis/redis.conf

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
