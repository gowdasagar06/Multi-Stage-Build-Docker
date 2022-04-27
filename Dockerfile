FROM node:17.9.0 AS builder

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY . .

RUN npm run build


# for production

FROM node:17.9.0-alpine3.15

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install --only=production

COPY --from=builder /usr/src/app/dist ./

EXPOSE 3000

ENTRYPOINT ["node","./app.js"]