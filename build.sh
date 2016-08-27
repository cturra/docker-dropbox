#!/bin/bash

IMAGE_NAME="cturra/dropbox"
BUILD_TAG=$(date '+%m%d%Y%M')
DOCKER=$(which docker)

# build image and tag with build tag (MonthDayYearMinute)
$DOCKER build --pull -t ${IMAGE_NAME}:${BUILD_TAG} .

# add latest tag
$DOCKER tag ${IMAGE_NAME}:${BUILD_TAG} ${IMAGE_NAME}:latest
