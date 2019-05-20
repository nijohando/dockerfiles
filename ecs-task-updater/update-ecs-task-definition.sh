#!/bin/bash

function check_env() {
  local var_name=$1
  if [ -z "${!var_name}" ]; then
    echo "Environment variable ${var_name} is required"
    exit 1
  fi
}

function usage() {
  echo "Usage: ${CMD_NAME} -f <family> -i <container image>"
  exit 1
}

SCRIPT_DIR=$(cd $(dirname $0); pwd)
CMD_NAME=$(basename $0)

check_env AWS_ACCESS_KEY_ID
check_env AWS_SECRET_ACCESS_KEY
check_env AWS_DEFAULT_REGION

while getopts :f:i:h OPT
do
  case $OPT in
    f) family=$OPTARG
      ;;
    i) image=$OPTARG
      ;;
    h) usage
      ;;
  esac
done

if [ -z $family ] || [ -z $image ]; then
  usage
fi

echo ""
echo "family: ${family}"
echo "image : ${image}"

cur_task=$(aws ecs describe-task-definition --task-definition=$family)

if [ $? -ne 0 ]; then
  echo "Failed to get current task definition '${family}'"
fi

echo ${cur_task} | jq --arg image ${image} '.taskDefinition | {family,taskRoleArn,executionRoleArn,networkMode,containerDefinitions, volumes, placementConstraints, requiresCompatibilities, cpu, memory, tags, pidMode, ipcMode} | .containerDefinitions[0].image = $image | with_entries(select(.value != null))' > new_task.json

aws ecs register-task-definition --cli-input-json file://${SCRIPT_DIR}/new_task.json

