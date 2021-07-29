FROM node:16 as builder

WORKDIR /unleash

COPY index.js package.json package-lock.json ./

RUN apt install python3
RUN npm i
RUN npm ci

FROM node:16-alpine

ENV NODE_ENV production

WORKDIR /unleash

COPY --from=builder /unleash /unleash

EXPOSE 4242

USER node

CMD node index.js
