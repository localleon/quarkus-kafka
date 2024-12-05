# Create kind cluster and load images/kubeconfig
kind create cluster --config devsetup-k8s/kind-cluster.yaml
kind get kubeconfig > /tmp/kindkubeconfig
export KUBECONFIG=/tmp/kindkubeconfig

# Install cert manager 
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install cert-manager jetstack/cert-manager \
  --set crds.enabled=true \
  --namespace cert-manager  \
  --create-namespace

# Install Redis 
helm upgrade --install redis --namespace redis --values devsetup-k8s/redis-values.yaml --create-namespace oci://registry-1.docker.io/bitnamicharts/redis

# Install redpanda operator 
kubectl kustomize "https://github.com/redpanda-data/redpanda-operator//operator/config/crd?ref=v2.3.0-24.3.1" | kubectl apply --server-side -f -

# Deploy Redpanda Operator
helm repo add redpanda https://charts.redpanda.com
helm upgrade --install redpanda-controller redpanda/operator \
  --namespace kafka \
  --create-namespace \
  --values devsetup-k8s/redpanda-operator-values.yaml

kubectl --namespace kafka rollout status --watch deployment/redpanda-controller-operator 

# Create RedPanda Kafka 
kubectl apply -f devsetup-k8s/redpanda-cluster.yaml --namespace kafka
kubectl apply -f devsetup-k8s/redpanda-static-nodeport.yaml --namespace kafka
kubectl get redpanda --namespace kafka 

# Define the container name and namespace
POD_NAME="redpanda-0"
NAMESPACE="kafka"
# Loop until the container is Running
while true; do
  STATUS=$(kubectl get pod "$POD_NAME" -n "$NAMESPACE" -o jsonpath='{.status.phase}' 2>/dev/null)

  if [[ "$STATUS" == "Running" ]]; then
    echo "$POD_NAME is Running!"
    break
  else
    echo "Current status: $STATUS. Waiting for kafka broker to start..."
    sleep 5
  fi
done

# Create Redpanda Topics 
kubectl apply -f devsetup-k8s/redpanda-topics.yaml
kubectl get topics.cluster.redpanda.com

# Check final status 
kubectl get pod --namespace kafka 

echo "======================"
echo "Dev Setup UP completed" 