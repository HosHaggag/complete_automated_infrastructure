FROM node:latest

WORKDIR /usr/src/app

# Copy package.json and package-lock.json separately to leverage Docker cache
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 3000

# Start Node.js application
CMD [ "node", "index.js" ]
