FROM node:21-bookworm-slim AS build

WORKDIR /app
COPY package*.json ./
RUN npm install

WORKDIR /app
COPY . .
RUN npm run build


FROM node:21-bookworm-slim AS runtime

RUN mkdir -p /app/.ts-node && chown -R node:node /app
WORKDIR /app

COPY package*.json ./
USER node

RUN npm install --only=production
COPY --chown=node:node --from=build /app/.ts-node ./.ts-node

EXPOSE 3000

ENTRYPOINT ["npm", "start"]

