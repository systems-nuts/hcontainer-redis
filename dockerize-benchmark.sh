#!/bin/bash

FOLDER=dockers/server

mkdir -p $FOLDER

cp src/redis-benchmark_aarch64 src/redis-benchmark_x86-64 src/redis-benchmark $FOLDER/
docker build --tag popcorn/redis-benchmark:latest -f $FOLDER/Dockerfile $FOLDER/
docker tag popcorn/redis-benchmark:latest 121389845380.dkr.ecr.us-east-1.amazonaws.com/popcorn/redis-benchmark:latest
docker push 121389845380.dkr.ecr.us-east-1.amazonaws.com/popcorn/redis-benchmark:latest
