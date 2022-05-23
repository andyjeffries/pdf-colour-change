FROM alpine

RUN apk add --no-cache imagemagick bash

ADD . /app

WORKDIR /app

