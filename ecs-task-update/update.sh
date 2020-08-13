#!/bin/bash

if [ -z ${PLUGIN_TASK_NAME} ]; then
  echo "missing task name"
  exit 1
fi

if [ -z ${PLUGIN_IMAGE_NAME} ]; then
  echo "missing task image name"
  exit 1
fi

if [ -z ${PLUGIN_AWS_REGION} ]; then
  echo "missing aws region"
  exit 1
fi

if [ -z ${PLUGIN_AWS_ACCESS_KEY_ID} ]; then
  echo "missing aws access key id"
  exit 1
fi

if [ -z ${PLUGIN_AWS_SECRET_ACCESS_KEY} ]; then
  echo "missing aws secret access key"
  exit 1
fi

export AWS_DEFAULT_REGION=${PLUGIN_AWS_REGION}
export AWS_ACCESS_KEY_ID=${PLUGIN_AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${PLUGIN_AWS_SECRET_ACCESS_KEY}

update-ecs-task-def.sh -f ${PLUGIN_TASK_NAME} -i ${PLUGIN_IMAGE_NAME}
