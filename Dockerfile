FROM node:10-alpine

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache \
      chromium@edge \
      harfbuzz@edge \
      nss@edge

WORKDIR /app

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

RUN yarn add puppeteer@1.9.0

COPY ./app ./

RUN addgroup -S puppeteer && adduser -S -g puppeteer puppeteer \
    && mkdir -p /home/puppeteer/Downloads \
    && chown -R puppeteer:puppeteer /home/puppeteer \
    && chown -R puppeteer:puppeteer /app

# Run everything after as non-privileged user.
USER puppeteer

CMD ["node", "/app/index.js"]
