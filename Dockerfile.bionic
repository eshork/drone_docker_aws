FROM ubuntu:bionic

RUN echo "Update the base image security and install dependencies" \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -qq \
  && apt-get install -y -qq --no-install-recommends apt-utils apt-transport-https ca-certificates software-properties-common bash curl \
  && apt-get upgrade -y -qq \
  # clean up apt caches
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && true


RUN echo "Install Docker" \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -qq \
  && apt-get install -y -qq --no-install-recommends gpg-agent \
  && apt-get remove -y docker docker-engine docker.io containerd runc \
  && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
  && add-apt-repository "deb [arch=amd64,trusted=yes,allow-insecure=yes] https://download.docker.com/linux/ubuntu bionic stable" \
  && apt-get install -y -qq --no-install-recommends docker-ce docker-ce-cli \
  # clean up apt caches
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && true


ENV DOCKERCOMPOSE_VERSION "1.24.1"
RUN echo "Install docker-compose" \
  && curl -L https://github.com/docker/compose/releases/download/${DOCKERCOMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o ./docker-compose \
  && chmod +x ./docker-compose \
  && mv ./docker-compose /usr/local/bin/docker-compose \
  && true


ADD --chown=root:root https://raw.githubusercontent.com/jpetazzo/dind/master/wrapdocker /usr/local/sbin/wrapdocker
RUN echo "Install docker-in-docker" \
  && apt-get update \
  && apt-get install -y --no-install-recommends dmsetup \
  && chmod +x /usr/local/sbin/wrapdocker \
  # clean up apt caches
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && chmod +x /usr/local/bin/* \
  && true


ENV AWSCLI_VERSION "1.14.10"
RUN echo "Install awscli" \
  && export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -qq \
  && apt-get install -y -qq --no-install-recommends python python-dev python-setuptools python-pip python-yaml \
  groff less \
  && pip install awscli==$AWSCLI_VERSION --upgrade \
  # clean up apt caches
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && true


# Latest KUBECTL_VERSION here: https://storage.googleapis.com/kubernetes-release/release/stable.txt
ENV KUBECTL_VERSION "v1.16.3"
RUN echo "Install kubectl" \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl \
  && true


COPY --chown=root:root aws-ecr-login.sh /usr/local/bin/aws-ecr-login
COPY --chown=root:root checksum.sh /usr/local/bin/checksum
COPY --chown=root:root epoch.sh /usr/local/bin/epoch
COPY --chown=root:root docker-ensure-image.sh /usr/local/bin/docker-ensure-image
COPY --chown=root:root kubectl-login.sh /usr/local/bin/kubectl-login
COPY --chown=root:root github-login.sh /usr/local/bin/github-login
COPY --chown=root:root ssh-debug-session.sh /usr/local/bin/ssh-debug-session
RUN echo "Install helper scripts and tools" \
  && apt-get update \
  && apt-get install -y --no-install-recommends iputils-ping dnsutils net-tools unzip openssh-server \
  git wget jq gettext \
  ruby rubygems \
  # Slack CLI
  && curl -O https://raw.githubusercontent.com/rockymadden/slack-cli/master/src/slack \
  && chmod +x slack \
  && mv slack /usr/local/bin/ \
  # GitHub CLI (both ghi and hub)
  && gem install ghi -v 1.2.0 \
  && (cd /tmp; wget https://github.com/github/hub/releases/download/v2.13.0/hub-linux-386-2.13.0.tgz) \
  && (cd /tmp; tar zxf hub-linux-386-2.13.0.tgz) \
  && (cd /tmp/hub-linux-386-2.13.0/bin; chown root:root hub; mv hub /usr/local/bin/hub) \
  && (cd /tmp; rm hub-linux-386-2.13.0.tgz; rm -r hub-linux-386-2.13.0) \
  # ngrok
  && (cd /tmp; wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip) \
  && (cd /tmp; unzip ngrok-stable-linux-amd64.zip) \
  && (cd /tmp; chown root:root ngrok; mv ngrok /usr/local/bin/ngrok) \
  && (cd /tmp; rm ngrok-stable-linux-amd64.zip) \
  # clean up apt caches
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && chmod +x /usr/local/bin/* \
  && rm -rf /tmp/* \
  && true


COPY --chown=root:root tsh /bin/tsh
RUN echo "Hijack /bin/sh" \
  && mv /bin/sh /bin/old.sh \
  && cp /bin/tsh /bin/sh \
  && true
COPY --chown=root:root docker-init.sh /docker-init.sh
ENTRYPOINT [ "/bin/sh" ]
