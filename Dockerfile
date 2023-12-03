FROM node:21-bookworm-slim AS build

USER node

WORKDIR /app
COPY --chown=node:node package*.json ./
RUN npm install

WORKDIR /app
COPY --chown=node:node . .
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

