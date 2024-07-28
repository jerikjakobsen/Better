source ./redis.env

redis-server --requirepass $REDIS_SECRET --port $REDIS_PORT &