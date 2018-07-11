#!/bin/bash

export AWS_SECRET_ACCESS_KEY=$(cat $AWS_SECRET_ACCESS_KEY_FILE)
export ENDPOINT_URL=$(aws eks describe-cluster --name $CLUSTER_NAME  --query cluster.endpoint)
export CERT_AUTH_DATA=$(aws eks describe-cluster --name $CLUSTER_NAME  --query cluster.certificateAuthority.data)
export CONFIG=$(cat /workspace/deploy/aws/.kube)
echo $CONFIG
#envsubst < /workspace/deploy/aws/.kube > ~/.kube

kubectl apply -f /workspace/deploy/k8s