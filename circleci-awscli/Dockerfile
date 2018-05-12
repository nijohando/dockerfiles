FROM alpine:3.5
LABEL maintainer "nijohando <mail@nijohando.jp>"

RUN apk --update add python3 ca-certificates openssh-client && \
  python3 -m pip install awscli
