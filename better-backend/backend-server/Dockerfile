FROM node:alpine

WORKDIR /Better

COPY ./.env.postgres ./.env.postgres
COPY ./.env.redis ./.env.redis
COPY ./.env.server ./.env.server

WORKDIR /Better/better-backend/backend-server

COPY ./better-backend/backend-server/src ./src
COPY ./better-backend/backend-server/index.js ./index.js
COPY ./better-backend/backend-server/package-lock.json ./package-lock.json
COPY ./better-backend/backend-server/package.json ./package.json

RUN npm install

EXPOSE ${NODE_SERVER_PORT}

CMD ["npm", "run", "start"]