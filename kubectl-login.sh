#!/bin/bash

set -e

kubectl config set-credentials drone-kube-user --token=$KUBECTL_TOKEN
kubectl config set-cluster drone-kube-cluster --server=$KUBECTL_HOST
kubectl config set-context drone --cluster=drone-kube-cluster --user=drone-kube-user
kubectl config use-context drone
