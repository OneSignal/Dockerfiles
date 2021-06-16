#!/usr/bin/env bash
set -e

echo ">>> Checking all configurations"
[[ "$DB_HOST" != "" ]] || ( echo 'Variable DB_HOST is not set!' ;exit 1 )
[[ "$DB_USER" != "" ]] || ( echo 'Variable DB_USER is not set!' ;exit 2 )
[[ "$DB_PASSWORD" != "" ]] || ( echo 'Variable DB_PASSWORD is not set!' ;exit 3 )
[[ "$DB_NAME" != "" ]] || ( echo 'Variable DB_NAME is not set!' ;exit 4 )

BACKUP_RETENTION_DAYS=${BACKUP_RETENTION_DAYS:-1}
BACKUP_SCHEDULE=${BACKUP_SCHEDULE:-'0 0 * * *'}
DB_PORT=${DB_PORT:-5432}
DB_CONNECTION_TIMEOUT=${DB_CONNECTION_TIMEOUT:-20}
BACKUP_DIR=${BACKUP_DIR:-/var/backups}

echo ">>> Configuring barman for streaming replication"
echo "
[pg_cluster]
description = 'Cluster pg_cluster replication'
backup_method = postgres
streaming_archiver = on
streaming_archiver_name = barman_receive_wal
streaming_archiver_batch_size = 50
conninfo = host=$DB_HOST dbname=$DB_NAME user=$DB_USER password=$DB_PASSWORD port=$DB_PORT connect_timeout=$DB_CONNECTION_TIMEOUT application_name=barman
streaming_conninfo = host=$DB_HOST user=$DB_USER password=$DB_PASSWORD port=$DB_PORT
backup_directory = $BACKUP_DIR
slot_name = barman
retention_policy = RECOVERY WINDOW OF $BACKUP_RETENTION_DAYS DAYS
" >> /etc/barman.d/upstream.conf

echo '>>> SETUP BARMAN CRON'
echo ">>>>>> Backup schedule is $BACKUP_SCHEDULE"
echo "$BACKUP_SCHEDULE /usr/bin/barman backup all > /proc/1/fd/1 2> /proc/1/fd/2" >> /barman/crontab

echo '>>> STARTING CRON'
env >> /barman/environment

# TODO: before starting our cron we need to start `barman receive-wal pg_cluster` in the background

if [[ "$DEBUG" = 'true' ]]; then
  sed -i 's/INFO/DEBUG/g' /etc/barman.conf

  supercronic -debug /barman/crontab
else
  supercronic /barman/crontab
fi
