FROM node:6-alpine

ENV PORT=3000

EXPOSE $PORT

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package.json package.json

RUN npm install --silent --progress=false && npm cache clean

COPY . .

RUN ["npm", "start"]