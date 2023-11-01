FROM node:20-slim

# Create app directory

WORKDIR /app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json /app

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . /app

ENV DBuser=admin
ENV DBpass=password
ENV DBhosts=mongo-0.mongo.default.svc.cluster.local:27017

EXPOSE 3000

CMD [ "node", "index.js" ]