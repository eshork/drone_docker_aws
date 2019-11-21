#!/bin/bash


if [ -n "$DOCKER_HOST" ]; then # If we have a DOCKER_HOST defined, use that
  echo "Existing DOCKER_HOST=$DOCKER_HOST"
else
  echo "Starting docker in docker..."
  LOG="file" /usr/local/sbin/wrapdocker true
fi

# Wait/loop for docker to be ready
TRIES=0
while ! /usr/bin/docker info &> /dev/null; do
  ((TRIES=TRIES+1))
  if ((TRIES >= 5 )); then
    echo "DOCKER NOT REACHABLE: 'docker info' failed continously"
    exit 1
  fi
  echo "Waiting for docker..."
  sleep 2
done

# Default to a bash shell if no command was given
if [ -z "$@" ]; then
  exec /bin/bash
fi

# Else just run the given command verbatim
echo $@
exec $@
