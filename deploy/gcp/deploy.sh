#!/bin/bash

gcloud auth activate-service-account $GCP_ACCOUNT --key-file=$GCP_KEY_FILE

gcloud container clusters get-credentials $GCP_CLUSTER --zone $GCP_ZONE --project $GCP_PROJECT

docker login --username $DOCKER_USERNAME --password $DOCKER_PASSWORD

kompose convert