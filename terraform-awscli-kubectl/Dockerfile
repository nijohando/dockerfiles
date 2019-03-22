## --------------------------------------------------------
## Build Terraform 0.12
## --------------------------------------------------------
FROM golang:alpine as terraform-builder

ENV TERRAFORM_VERSION=0.12.0-beta1
ENV TF_DEV=true
ENV TF_RELEASE=true

RUN apk add --update git bash openssh

WORKDIR ${GOPATH}/src/github.com/hashicorp/terraform

RUN git clone https://github.com/hashicorp/terraform.git ./
RUN git checkout v${TERRAFORM_VERSION}
RUN /bin/bash scripts/build.sh

## --------------------------------------------------------
## Prepare Terraform 0.12 providers
## --------------------------------------------------------
FROM alpine:latest as terraform-providers

ENV ARCH=linux_amd64
ENV REPO=http://terraform-0.12.0-dev-snapshots.s3-website-us-west-2.amazonaws.com

ENV AWS_PROVIDER_NAME=terraform-provider-aws
ENV AWS_PROVIDER_VERSION=1.60.0-dev20190216H00-dev
ENV AWS_PROVIDER_ZIP=${AWS_PROVIDER_NAME}_${AWS_PROVIDER_VERSION}_${ARCH}.zip

ENV TEMPLATE_PROVIDER_NAME=terraform-provider-template
ENV TEMPLATE_PROVIDER_VERSION=2.1.0-dev20190216H00-dev
ENV TEMPLATE_PROVIDER_ZIP=${TEMPLATE_PROVIDER_NAME}_${TEMPLATE_PROVIDER_VERSION}_${ARCH}.zip

RUN apk add --update curl unzip
RUN mkdir -p /work/dot_terraform_d/plugins/${ARCH}

WORKDIR /work/dot_terraform_d/plugins/${ARCH}
RUN curl -L -O ${REPO}/${AWS_PROVIDER_NAME}/${AWS_PROVIDER_VERSION}/${AWS_PROVIDER_ZIP}
RUN curl -L -O ${REPO}/${TEMPLATE_PROVIDER_NAME}/${TEMPLATE_PROVIDER_VERSION}/${TEMPLATE_PROVIDER_ZIP}
RUN unzip ${AWS_PROVIDER_ZIP} && rm ${AWS_PROVIDER_ZIP}
RUN unzip ${TEMPLATE_PROVIDER_ZIP} && rm ${TEMPLATE_PROVIDER_ZIP}

## --------------------------------------------------------
## Create command container
## --------------------------------------------------------
FROM alpine:latest
LABEL maintainer "nijohando <mail@nijohando.jp>"

ENV K8S_VERSION=v1.13.4

COPY --from=terraform-builder /go/bin/terraform /usr/local/bin
COPY --from=terraform-providers /work/dot_terraform_d /root/.terraform.d

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
