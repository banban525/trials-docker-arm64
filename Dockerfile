FROM node:21-bookworm-slim

# RUN apk --no-cache -U upgrade
RUN mkdir -p /app && chown -R node:node /app
WORKDIR /app

COPY package*.json ./
USER node

RUN npm install
COPY . .

ENTRYPOINT ["npm", "start"]

