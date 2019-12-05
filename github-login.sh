#!/bin/bash

set -e

GITHUB_USERNAME=$GITHUB_USERNAME
GITHUB_TOKEN=$GITHUB_TOKEN

# config hub
mkdir -p $HOME/.config
HUB_CONFIG=$HOME/.config/hub
cat > $HUB_CONFIG <<EOF
github.com:
- user: $GITHUB_USERNAME
  oauth_token: $GITHUB_TOKEN
  protocol: https
EOF
chmod 600 $HUB_CONFIG

# config ghi
git config --global ghi.user $GITHUB_USERNAME
git config --global ghi.token $GITHUB_TOKEN
