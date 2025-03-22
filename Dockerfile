FROM node:22 AS build

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --production

COPY . .

FROM node:22-alpine

WORKDIR /usr/src/app

COPY --from=build /usr/src/app .

EXPOSE 3000

CMD ["node", "index.js"]
