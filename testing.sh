# Test application endpoint 
echo "If you have run all the previous steps, the application is deployed in kuberentes and exposed under http://localhost:9091/produce/send"
echo "Connecting to service....." 
curl -X POST http://localhost:9091/produce/send -H "Content-Type: application/json" -d '{"productId": 123456, "quantity": 100}'

# Check kubernetes stuff
echo "Checking logs from producer1 service" 
export KUBECONFIG=/tmp/kindkubeconfig
kubectl logs -n kafka deployments/producer1-deployment

echo "Please verify in Redpanda console that the message has been successfully produced!" 