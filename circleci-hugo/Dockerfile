FROM alpine:3.5
LABEL maintainer "nijohando <mail@nijohando.jp>"

WORKDIR /home/hugo
RUN apk --update add curl git ca-certificates openssh-client && \
  mkdir tmp && \
  curl -L -o hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v0.40.3/hugo_0.40.3_Linux-64bit.tar.gz && \
  tar -zxf hugo.tar.gz -C tmp && \
  mv tmp/hugo /usr/local/bin && \
  rm -rf hugo.tar.gz tmp && \
  apk del curl
