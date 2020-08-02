FROM node:12-buster as builder

WORKDIR /work/ts-auth-api

COPY ./package.json /work/ts-auth-api
COPY ./yarn.lock /work/ts-auth-api
COPY ./tsconfig.json /work/ts-auth-api
COPY ./src /work/ts-auth-api/src

RUN yarn install
RUN yarn build

FROM node:12-buster-slim

WORKDIR /ts-auth-api

COPY --from=builder /work/ts-auth-api/dist ./dist
COPY --from=builder /work/ts-auth-api/node_modules ./node_modules

CMD [ "node", "./dist/server.js" ]
