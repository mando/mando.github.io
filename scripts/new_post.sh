#!/bin/bash

POST_NAME=$1

if [[ -z ${POST_NAME} ]]; then
  echo "Usage: ./scripts/new_post.sh \"Brilliant thought piece\""
  echo "Please provide a post name."
  exit;
fi

DATE=$(date +%Y-%m-%d)
FILENAME=${DATE}-$(echo ${POST_NAME} \
  | tr '[:upper:]' '[:lower:]' \
  | sed s/[[:punct:]]//g \
  | sed s/[[:space:]]/-/g ).md

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FULL_PATH=${DIR}/../_posts/${FILENAME}

cat << NEW_POST > ${FULL_PATH}
---
title: ${POST_NAME}
---
NEW_POST

$EDITOR ${FULL_PATH}
