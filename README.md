# Better

Better is an iOS app that allows users to track their exercises and routines. It also allows for analysis of their exercise routines as well as customization.

## Tech Stack

* Swift
* Node.js
* Postgres
* Redis
* Docker

## Set Up

* Postgres
    * Make sure a postgres server instance is running, with the following env variables set:
        - PGPASSWORD=X
        - PGUSER=X
        - PGDATABASE=X
        - PGPORT=X
        - PGHOST=X
    * Make sure pg_hba.conf file is configured to accept connections via md5 from the devices that are connecting to the database (docker container or device hosting the node server), as well as firewall rules allow the connection.
        * You can find this file with ```SHOW hba_file;``` while in the psql shell.
    * Make sure the postgres user indicated is created in the postgres instance with the password indicated
    * To connect to the postgres shell as the user run ```psql -h <REMOTE HOST> -p <REMOTE PORT> -U <DB_USER> -d <DB_NAME> -W```
    * Postgres can be started (in ubuntu) with systemctl ```sudo systemctl start postgres```

* Redis
    * Make sure a redis server instance is running with the following env variables set:
        - REDIS_PORT=X
        - REDIS_HOST=X
        - REDIS_SECRET=X
    * Make sure firewall rules are set to allow access to redis from devices that need it
    * Run ```./better-backend/start-redis.sh``` to start redis

* Node Server
    * Make sure the following env variables are set:
        - NODE_SERVER_PORT=X
        - ENVIRONMENT=DEV or PROD
        - SESSION_SECRET=X
        - TOKEN_EXPIRY=X
        - SERVER_KEY=X
        - HASH_SECRET=X
        - HASH_POWER=X
        - HASH_LENGTH=X
        - HASH_TIME_COST=X
    * Development
        * In development, you only need to run ```npm install``` and ```npm run start``` in the ```./better-backend/backend-server/``` directory
    * Production
        * Docker is used to run the server in production, to start the server in production run ```./better-backend/docker-compose.sh``` (This script just runs docker compose up and injects the necessary env file into it)
* Env File Structure

    * All env files are located in the root of the project. The three necessary env files are:

    .env.postgres
    ```
        PGPASSWORD=
        PGUSER=
        PGDATABASE=
        PGPORT=
        PGHOST=
    ```

    .env.redis
    ```
        REDIS_PORT=
        REDIS_HOST=
        REDIS_SECRET=
    ```

    .env.server
    ```
       NODE_SERVER_PORT=X
        ENVIRONMENT=DEV or PROD
        SESSION_SECRET=X
        TOKEN_EXPIRY=X

        SERVER_KEY=X

        HASH_SECRET=X
        HASH_POWER=X
        HASH_LENGTH=X
        HASH_TIME_COST=X
    ```