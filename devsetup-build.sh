# Build Producer1 Package with Maven 
cd producer1/ 
./mvnw package
docker build -f src/main/docker/Dockerfile.jvm -t quarkus/producer1-jvm:latest ./
kind load docker-image quarkus/producer1-jvm:latest

# Build Consumer1 package with maven 

# Deploy to Kubernetes 
export KUBECONFIG=/tmp/kindkubeconfig
kubectl apply -f devsetup-k8s/app-deployments.yaml
kubectl --namespace kafka rollout status --watch deployment/producer1-deployment