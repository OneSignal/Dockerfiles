FROM debian:10.9-slim

WORKDIR /barman

CMD /barman/entrypoint.sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget gnupg2 && \
    rm -rf /var/lib/apt/lists/*

# Install SuperCronic a Cron replacement which is able to run as non-root user
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=048b95b48b708983effb2e5c935a1ef8483d9e3e

RUN wget "$SUPERCRONIC_URL" \
 && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
 && chmod +x "$SUPERCRONIC" \
 && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
 && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

# Install postgresql client and Barman. Barman is part of the Postgresql apt repository
RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add - && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-client-10 barman=2.12-1.pgdg100+1 && \
    rm -rf /var/lib/apt/lists/*

COPY crontab /barman/crontab
COPY barman.conf /etc/barman.conf
COPY entrypoint.sh .

# Align the barman user with uuid 5000
RUN usermod -u 5000 barman

# Make sure all necessary folders are accesible by Barman user (uid 5000)
RUN mkdir /barman/postgres && \
    chmod 0755 /etc && \
    chown +5000:+5000 /etc && \
    chown -R +5000:+5000 /barman && \
    chown -R +5000:+5000 /etc/cron.d && \
    chown +5000:+5000 /etc/barman.conf && \
    chown -R +5000:+5000 /etc/barman.d
#    chmod 0755 /etc/barman.conf && \
