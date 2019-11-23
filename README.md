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
- GitHub CLI (https://github.com/stephencelis/ghi)
- General troubleshooting (ifconfig, ping, nslookup, dig, vim, jq)


## Surprisingly Small
The two primary functions of the image (Docker and AWS CLI) contribute the most to the image size.
To combat this, the image is purposefully layered to reduce download times, but there's only so much
that can be done within reason. The `alpine` build is the smallest image -- `alpine` is also the default
if you just pull `latest`.


## Helpful pre-built shell commands
Some of these are admittedly very basic, but it can be quite useful to have a known
good set of CI related shell commands.

- `checksum` \
  Generates an md5 checksum from all given files or from a piped stream. \
  Usage:
  ```
  > checksum file1 file2
  c91296498ebfca9ff40ab6f1ad718125
  > cat file1 file2 | checksum
  c91296498ebfca9ff40ab6f1ad718125
  ````


- `epoch` \
  Returns the current seconds since Unix epoch \
  Usage:
  ```
  > epoch
  1574465913
  ```


- `docker-ensure-image` \
  Ensures the given image name/tag are available in the local docker images store. \
  Tries to pull missing images and returns a non-zero exit code when the image \
  cannot be ensured. Useful for coordinating multi-stage builds across multiple \
  Dockerfiles. \
  Usage:
  ```
  > docker-ensure-image myimage:latest || docker build -t myimage:latest .
  ```


- `aws-ecr-login` \
  Logs Docker in to AWS ECR, using the default AWS CLI credentials. \
  AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION \
  Usage:
  ```
  > aws-ecr-login
  Login Succeeded
  ```


- `kubectl-login` \
  Generates a kubectl config file (~/.kube/config) from KUBECTL_HOST and KUBECTL_TOKEN environment variables. \
  Usage:
  ```
  > kubectl-login
  User "drone-kube-user" set.
  Cluster "drone-kube-cluster" set.
  Context "drone" modified.
  Switched to context "drone".
  ````
