#!/bin/bash

IMAGE=$1

docker pull $IMAGE

docker stop app || true
docker rm app || true

docker run -d -p 3000:3000 --name app $IMAGE