# quarkus-kafka / Simple Dev Setup with Kubernetes and Kafka 

This repo demonstrates how to get a simple Kafka cluster running on a local kubernetes stack to develop a quarkus applications. 

We deploy the following stack: 
- Local Kind cluster
- Local Redis 
- Local RedPanda Kafka Operator 
- Development Topics 
- Build chain for Quarkus application 

Use the following scripts to perform the testing: 

```bash 
# Create devsetup 
devsetup-up.sh 
# You can now develope with quarkus dev 
cd producer1 && quarkus dev 
# Load applicatiosn for integration test 
devsetup-build.sh 
# Run in seperate terminal to forward console/services 
devsetup-forward.sh 
# Performe testing via script 
testing.sh 
```
