#!/bin/bash

# grab global variables
source vars

DOCKER=$(which docker)

# build image
$DOCKER build --pull --no-cache --tag ${IMAGE_NAME} .
