#!/bin/bash

set -ex

GCR_PROJECT_NAME=$1
IMAGE_NAME=gcr.io/${GCR_PROJECT_NAME}/controller

docker build -t ${IMAGE_NAME}  .
docker push ${IMAGE_NAME}:latest