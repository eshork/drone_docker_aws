#!/bin/bash

set -e

docker run --rm \
  --entrypoint=/bin/sh \
  -e DOCKER_HOST=unix:///var/host-run/docker.sock \
  -v /var/run/docker.sock:/var/host-run/docker.sock \
  -v ${PWD}:/drone/src \
  -e DRONE_SCRIPT="pwd;ls" \
  -it drone_docker_aws:alpine -c "echo \"\$DRONE_SCRIPT\" | /bin/sh"

# docker run --rm --privileged \
#   --entrypoint=/bin/sh \
#   -v ${PWD}:/drone/src \
#   -e DRONE_SCRIPT="pwd;ls" \
#   -it drone_docker_aws:alpine -c "echo \"\$DRONE_SCRIPT\" | /bin/sh"

# docker run --rm --privileged \
#   --entrypoint=/bin/sh \
#   -v ${PWD}:/drone/src \
#   -e DRONE_SCRIPT="pwd;ls" \
#   -it drone_docker_aws:alpine docker version

docker run --rm \
  -e DOCKER_HOST=unix:///var/host-run/docker.sock \
  -v /var/run/docker.sock:/var/host-run/docker.sock \
  -v ${PWD}:/drone/src \
  -e DRONE_SCRIPT="pwd;ls" \
  -it drone_docker_aws:alpine
