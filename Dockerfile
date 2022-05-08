# Stage 1 building the code
FROM node:16-alpine3.11 as builder

WORKDIR /usr/app

COPY package*.json .

RUN npm install --silence

COPY . .

# RUN npm run migrations:run

RUN npm run build

# Stage 2
FROM node:16-alpine3.11

COPY package*.json ./

RUN npm install --production

COPY --from=builder /usr/app/dist ./dist

EXPOSE 3000

CMD [ "npm", "start"]
