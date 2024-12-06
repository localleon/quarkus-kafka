
#!/bin/bash

# Define the services and ports to forward
declare -A SERVICES
SERVICES=(
  ["redpanda-console"]="9090:8080"    # Format: "local_port:service_port"
#   ["redpanda"]="9093:9093" # kafka cannot directly be forwarded via port-forward, we need to use nodeport
  ["producer1-service"]="9091:8080"
)

NAMESPACE=kafka

# Array to hold background process PIDs
PIDS=()


# Function to clean up background processes
cleanup() {
  echo "Cleaning up..."
  for pid in "${PIDS[@]}"; do
    kill "$pid" 2>/dev/null
  done
  echo "All processes killed."
  exit
}

# Trap Ctrl+C (SIGINT) and call cleanup
trap cleanup SIGINT
export KUBECONFIG=/tmp/kindkubeconfig

# Start port-forwarding for each service
for service in "${!SERVICES[@]}"; do
  ports="${SERVICES[$service]}"
  echo "Port-forwarding $service on $ports"
  kubectl port-forward -n $NAMESPACE service/"$service" $ports &
  PIDS+=($!)
done

# Wait for all background processes
wait
