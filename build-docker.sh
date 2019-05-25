#!/bin/bash

FOLDER=dockers/server

mkdir -p $FOLDER

cp src/redis-server_aarch64 src/redis-server_x86-64 src/redis-server $FOLDER/
docker build --tag popcorn/redis:latest -f $FOLDER/Dockerfile $FOLDER/
docker tag popcorn/redis:latest 121389845380.dkr.ecr.us-east-1.amazonaws.com/popcorn/redis:latest
docker push 121389845380.dkr.ecr.us-east-1.amazonaws.com/popcorn/redis:latest
