#!/bin/bash

rm -rf /workspace/deploy/k8s/*.yaml
kompose -f /workspace/docker-compose.yml convert

# fix until https://github.com/kubernetes/kompose/issues/1036, forcing pull of latest each time for testing
for DEPLOYMENT in $(find /workspace/deploy/k8s/*-deployment.yaml -type f)
do
    sed -i -e 's/image:/imagePullPolicy: Always\n        image:/g' $DEPLOYMENT
done

# no koompose mapping, jenkins runs not as root which break volume permissiong unless securityContext set properly
sed -i -e 's/containers:/securityContext:\n        fsGroup: 1000\n      containers:/g' /workspace/deploy/k8s/jenkins-deployment.yaml

# fix until https://github.com/kubernetes/kompose/issues/1046, shared volume between master and agents
#sed -i -e 's/ReadWriteOnce/ReadWriteMany/g' /workspace/deploy/k8s/jenkins-persistentvolumeclaim.yaml