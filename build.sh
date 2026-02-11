#!/bin/bash

# 빌드 실행
docker buildx create --use

# 빌드 시작 (플랫폼 지정, 태그 추가, 푸시)
docker buildx build --platform linux/amd64,linux/arm64 \
  -t chillingdaisy/openclaw-easy:v1.4 \
  --push .
