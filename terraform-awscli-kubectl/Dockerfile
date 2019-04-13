## --------------------------------------------------------
## Build Terraform 0.12
## --------------------------------------------------------
FROM golang:alpine as terraform-builder

ENV TERRAFORM_VERSION=0.11.13
ENV TF_DEV=true
ENV TF_RELEASE=true

RUN apk add --update git bash openssh

WORKDIR ${GOPATH}/src/github.com/hashicorp/terraform

RUN git clone https://github.com/hashicorp/terraform.git ./
RUN git checkout v${TERRAFORM_VERSION}
RUN /bin/bash scripts/build.sh

## --------------------------------------------------------
## Create command container
## --------------------------------------------------------
FROM alpine:latest
LABEL maintainer "nijohando <mail@nijohando.jp>"

ENV K8S_VERSION=v1.13.4

COPY --from=terraform-builder /go/bin/terraform /usr/local/bin

RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates curl groff less && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/* && \
    curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${K8S_VERSION}/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    curl -L -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/local/bin/aws-iam-authenticator && \
    mkdir /work

WORKDIR /work
ENTRYPOINT ["terraform"]
