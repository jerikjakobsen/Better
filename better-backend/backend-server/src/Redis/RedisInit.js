import dotenv from 'dotenv'
dotenv.config({
    path: ["../../.env.server", "../../.env.redis", "../../.env.postgres"]
})
import Redis from 'ioredis'
import session from 'express-session';
import RedisStore from "connect-redis"

console.log("Configuring Redis store...")
const redisClient = new Redis({
    port: Number(process.env.REDIS_PORT),
    host: process.env.REDIS_HOST,
    password: process.env.REDIS_SECRET
})

redisClient.on('error', function (err) {
    console.log('Could not establish a connection with redis. ' + err);
});

redisClient.on('connect', function (err) {
    console.log('Connected to redis successfully');
});

const redisStore = new RedisStore({
    client: redisClient
})

const redisSession = session({
    store: redisStore,
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
})

export {
    redisSession
}