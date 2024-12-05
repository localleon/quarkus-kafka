# Create kind cluster and load images/kubeconfig
kind create cluster --image kindest/node:v1.31.2
kind get kubeconfig > /tmp/kindkubeconfig
export KUBECONFIG=/tmp/kindkubeconfig

# Install cert manager 
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm upgrade --install cert-manager jetstack/cert-manager \
  --set crds.enabled=true \
  --namespace cert-manager  \
  --create-namespace

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
kubectl get redpanda --namespace kafka --watch
# Create Redpanda Topics 
kubectl apply -f devsetup-k8s/redpanda-cluster.yaml

# Check final status 
kubectl get pod --namespace kafka 

echo "======================"
echo "Dev Setup UP completed" 