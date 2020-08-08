FROM node:10.17-alpine as builder

RUN mkdir -p /opt

# install os dependecies
RUN apk update
RUN apk add --no-cache git build-base gcc abuild make bash python python3

RUN yarn global add linklocal

WORKDIR /opt

# install dependencies first
COPY package*.json yarn*.lock ./
RUN yarn install --production=false
ENV PATH /opt/node_modules/.bin:$PATH

# copy in our source code last, as it changes the most
COPY . /opt

RUN npm run build

RUN linklocal -r
