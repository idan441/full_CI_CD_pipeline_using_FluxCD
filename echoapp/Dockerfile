FROM mhart/alpine-node:12

WORKDIR /app

ADD . ./
RUN yarn

ENTRYPOINT ["yarn", "run", "start"]
