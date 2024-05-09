#!/bin/bash

# Set the path to the Kubernetes YAML files
K8S_DIR="./k8s"

# Function to check command success
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error occurred while executing: $1"
        exit 1
    fi
}

echo "Deploying application components..."


echo "Deploying deployment.yaml..."
kubectl apply -f "$K8S_DIR/deployment.yml"
check_success "kubectl apply -f $K8S_DIR/deployment.yml"
kubectl get pods
check_success "kubectl get pods"


echo "Deploying service.yaml..."
kubectl apply -f "$K8S_DIR/service.yaml"
check_success "kubectl apply -f $K8S_DIR/service.yaml"
kubectl get services
check_success "kubectl get services"


echo "Deploying ingress.yaml..."
kubectl apply -f "$K8S_DIR/ingress.yaml"
check_success "kubectl apply -f $K8S_DIR/ingress.yaml"
kubectl get ingresses
check_success "kubectl get ingresses"

echo "Creating monitoring namespace..."

kubectl apply -f "$K8S_DIR/monitoring-namespace.yaml"
check_success "kubectl apply -f $K8S_DIR/monitoring-namespace.yaml"
kubectl get namespaces
check_success "kubectl get namespaces"

echo "Deploying monitoring components..."

kubectl apply -f "$K8S_DIR/monitoring-components.yaml"
check_success "kubectl apply -f $K8S_DIR/monitoring-components.yaml"
kubectl get all -n monitoring
check_success "kubectl get all -n monitoring"
kubectl get pods -n monitoring
check_success "kubectl get pods -n monitoring"
kubectl get deployments -n monitoring
check_success "kubectl get deployments -n monitoring"

echo "Running timeout job..."

kubectl apply -f "$K8S_DIR/timeout-job.yaml"
check_success "kubectl apply -f $K8S_DIR/timeout-job.yaml"
kubectl get jobs
check_success "kubectl get jobs"
kubectl describe job timeout-sample-nodejs-job
check_success "kubectl describe job timeout-sample-nodejs-job"

echo "Applying role and role binding..."

kubectl apply -f "$K8S_DIR/readonly-role.yaml"
check_success "kubectl apply -f $K8S_DIR/readonly-role.yaml"
kubectl describe role readonly-role
check_success "kubectl describe role readonly-role"
kubectl get roles
check_success "kubectl get roles"

kubectl apply -f "$K8S_DIR/readonly-role-binding.yaml"
check_success "kubectl apply -f $K8S_DIR/readonly-role-binding.yaml"
kubectl get rolebindings
check_success "kubectl get rolebindings"

echo "Setup complete."
