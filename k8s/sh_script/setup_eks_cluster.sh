#!/bin/bash

echo "Creating EKS cluster..."
eksctl create cluster --name test --region us-east-1 --nodegroup-name standard-workers --node-type t3.medium --nodes 2 --nodes-min 1 --nodes-max 3 --managed

echo "Getting EKS cluster information..."
eksctl get cluster

echo "Updating kubeconfig..."
aws eks update-kubeconfig --name test --region us-east-1

echo "EKS cluster setup complete."
