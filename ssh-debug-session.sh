#!/bin/bash

mkdir -p /run/sshd

#host keys...
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
  ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi
if [ ! -f /etc/ssh/ssh_host_dsa_key ]; then
  ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
fi

# permit sshd root login
if ! cat /etc/ssh/sshd_config | grep "PermitRootLogin yes"; then
  echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
fi

# set a root password if needed
if cat /etc/shadow | grep -E 'root:(!|\*|:)' &>/dev/null; then
  NEWPASS=`hostname`
  echo "NEW SSH ROOT PASSWORD: $NEWPASS"
  echo -e "$NEWPASS\n$NEWPASS" | passwd root &>/dev/null
fi

if [ -z "$NGROK_TOKEN" ]; then
  echo "You must provide your ngrok authtoken via the NGROK_TOKEN env var"
  echo "Go to https://dashboard.ngrok.com and set up an account if you need one"
  exit 1
fi

ngrok authtoken $NGROK_TOKEN
/usr/sbin/sshd
ngrok tcp 22 --log "stdout"
pkill sshd
