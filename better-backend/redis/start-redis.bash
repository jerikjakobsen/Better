source ../../.env.redis

redis-server --requirepass $REDIS_SECRET --port $REDIS_PORT &