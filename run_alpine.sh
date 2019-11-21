#!/bin/bash

docker run --rm --privileged \
  -e DOCKER_HOST=unix:///var/host-run/docker.sock \
  -v /var/run/docker.sock:/var/host-run/docker.sock \
  -v ${PWD}:/drone/src \
  -it drone_docker_aws:alpine
