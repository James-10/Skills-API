#!/bin/bash

IMAGE_NAME="skills-api"
IMAGE_TAG="dev"
APPLICATION_NAME="skills-api"
CONFIGMAP_NAME="skills-api-configs"

if ! minikube status;
then 
    minikube delete
    minikube start --memory=4g cpus=2
fi

eval $(minikube docker-env)

kubectl delete service $APPLICATION_NAME
kubectl delete deployment $APPLICATION_NAME

docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfile .

kubectl create configmap $CONFIGMAP_NAME --from-env-file=.env
kubectl create deployment $APPLICATION_NAME --image=$IMAGE_NAME:$IMAGE_TAG

kubectl expose deployment $APPLICATION_NAME --type=NodePort --port=8080 --port=5432

# SKILLS_API_URL=$(minikube service $APPLICATION_NAME --url)

# echo "skills-api is at: $SKILLS_API_URL"

minikube service $APPLICATION_NAME