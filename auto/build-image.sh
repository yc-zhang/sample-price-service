#!/usr/bin/env bash
VERSION=${BUILD_ID} # jenkins build id

LOCAL_IMAGE_NAME=sample-price-service
LAST_LOCAL_IMAGE_NAME=${LOCAL_IMAGE_NAME}:latest
#REMOTE_IMAGE_NAME=625190582435.dkr.ecr.ap-northeast-2.amazonaws.com/${LOCAL_IMAGE_NAME}

docker-compose --project-name sample-price-service \
    run --rm publish ./build.sh

docker build -t ${LOCAL_IMAGE_NAME} .

#docker tag ${LOCAL_IMAGE_NAME} ${REMOTE_IMAGE_NAME}:latest
#docker tag ${LOCAL_IMAGE_NAME} ${REMOTE_IMAGE_NAME}:${VERSION}

#$(aws ecr get-login --no-include-email --region ap-northeast-2) # let's login for this guy
#
#docker push ${REMOTE_IMAGE_NAME}:${VERSION}
#docker push ${REMOTE_IMAGE_NAME}:latest
