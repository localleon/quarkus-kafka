export KUBECONFIG=/tmp/kindkubeconfig
echo "RedPanda Console available on http://localhost:8081/overview" 
kubectl port-forward -n kafka services/redpanda-console 9090:8080