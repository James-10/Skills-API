#!/bin/bash

IMAGE_NAME="skills-api"
IMAGE_TAG="dev"
APPLICATION_NAME="skills-api"
CONFIGMAP_NAME="skills-api-configs"
K8S_PATH="../deployment/kubernetes"

if ! minikube status;
then 
    minikube delete
    minikube start --memory=4g cpus=2
fi

eval $(minikube docker-env)

kubectl delete service $APPLICATION_NAME
kubectl delete deployment $APPLICATION_NAME

docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfile .

kubectl create secret generic skills-api-secrets --from-env-file=.env
kubectl apply -f $K8S_PATH/deployment.yaml
kubectl apply -f $K8S_PATH/service.yaml

minikube service $APPLICATION_NAME