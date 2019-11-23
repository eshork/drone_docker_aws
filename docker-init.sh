#!/bin/bash

# Ensures that the docker daemon is running

if [ -z "$DOCKER_HOST" ]; then # If we have no DOCKER_HOST defined, make our own
  if ! /usr/bin/docker info &> /dev/null; then
    export DOCKER_IN_DOCKER=1
    if [ -z "$KUBERNETES_PORT" ]; then
      DOCKER_DAEMON_ARGS="-H 0.0.0.0:2375 -H unix:///var/run/docker.sock" LOG=file /usr/local/sbin/wrapdocker &
    else
      DOCKER_DAEMON_ARGS="-H :2375 -H unix:///var/run/docker.sock" LOG=file /usr/local/sbin/wrapdocker &
    fi
  fi
# else
#   echo "FOUND DOCKER_HOST=$DOCKER_HOST"
fi

# Wait/loop for docker to be ready
TRIES=0
while ! /usr/bin/docker info &> /dev/null; do
  ((TRIES=TRIES+1))
  if ((TRIES > 30 )); then
    echo "DOCKER NOT REACHABLE: 'docker info' failed continously"
    if [ -n $DOCKER_IN_DOCKER ]; then
      echo "NOTE: docker-in-docker requires --privileged docker execution"
      cat /var/log/docker.log
    fi
    echo "DOCKER_HOST=$DOCKER_HOST"
    exit 1
  fi
  # echo "Waiting for docker..."
  sleep 1
done
