FROM node:alpine

WORKDIR /app

RUN npm install -g nodemon ts-node

COPY ./ ./

RUN npm install

EXPOSE ${NODE_SERVER_PORT}

CMD ["npm", "run", "start"]