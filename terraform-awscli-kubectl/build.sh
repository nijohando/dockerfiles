#!/bin/bash

DOCKER_BUILDKIT=1 docker build . -t nijohando/terraform-awscli-kubectl:0.12.0-beta1
