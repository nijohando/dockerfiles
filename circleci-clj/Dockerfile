FROM circleci/clojure:latest-node
LABEL maintainer "nijohando <mail@nijohando.jp>"

RUN sudo apt-get update \
    && sudo apt-get install -y \
       curl rlwrap build-essential

RUN curl -O https://download.clojure.org/install/linux-install-1.9.0.358.sh \
    && chmod +x linux-install-1.9.0.358.sh \
    && sudo ./linux-install-1.9.0.358.sh
