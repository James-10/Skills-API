IMAGE_NAME="skills-api"
IMAGE_TAG="dev"
APPLICATION_NAME="skills-api"
release_name="skills-api"
chart_path="../deployment/skills-api-chart"

if ! minikube status;
then 
    minikube delete
    minikube start --memory=4g cpus=2
fi

docker build -t $IMAGE_NAME:$IMAGE_TAG -f Dockerfile .

eval $(minikube docker-env)

helm uninstall $release_name

helm install "$release_name" "$chart_path"