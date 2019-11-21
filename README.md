# Drone + Docker + Aws
A docker image for adhoc command executions within Drone.io workflows, with AWS CLI, Docker/docker-compose, and many other useful tools already installed

## Batteries Included
- Docker
- docker-compose
- docker-in-docker (dind) - starts automatically unless you provide a DOCKER_HOST env var
- kubectl
- awscli
- git
- Slack CLI (https://github.com/rockymadden/slack-cli)
- GitHub CLI (https://github.com/jsmits/github-cli)
- General troubleshooting (ifconfig, ping, nslookup, dig, vim)

## Surprisingly Small
The two primary functions of the image (Docker and AWS CLI) contribute the most to the image size.
To combat this, the image is purposefully layered to reduce download times, but there's only so much
that can be done within reason. The `alpine` build is the smallest image -- `alpine` is also the default
if you just pull `latest`.
