FROM alpine:latest
LABEL maintainer "nijohando <mail@nijohando.jp>"

RUN apk --no-cache update && \
    apk --no-cache add bash jq python py-pip py-setuptools ca-certificates curl groff less && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/* && \
    mkdir /work
COPY ./update-ecs-task-def /usr/local/bin
RUN chmod +x /usr/local/bin/update-ecs-task-def
WORKDIR /work
