#!/bin/bash

IMAGE_NAME="skills-api"
IMAGE_TAG="dev"
APPLICATION_NAME="skills-api"
release_name="skills-api"
chart_path="../deployment/skills-api-helm"
SECRET_MANIFEST="skills-api-secrets"

while read -r line || [[ -n "$line" ]]; do
    if [[ "$line" != "#" ]]; then
        IFS='=' read -r key value <<< "$line"
        export "$key"="$value"
    fi
done < ".env"

if ! minikube status;
then 
    minikube delete
    minikube start --memory=4g cpus=2
fi

kubectl delete secret $SECRET_MANIFEST

docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfile .

eval $(minikube docker-env)

helm uninstall $release_name

helm install $release_name $chart_path --set postgres.user=$pg_skills_user --set postgres.password=$pg_skills_password

minikube service $APPLICATION_NAME