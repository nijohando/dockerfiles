FROM circleci/golang:latest
LABEL maintainer "nijohando <mail@nijohando.jp>"

RUN sudo apt-get update \
    && sudo apt-get install -y \
       hugo python-pip

RUN pip install awscli
