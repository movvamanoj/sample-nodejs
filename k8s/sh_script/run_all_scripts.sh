#!/bin/bash

# Set execute permissions for setup kubectl eksctl script
chmod +x setup_kubectl_eksctl.sh

echo "Executing setup kubectl eksctl script..."
./setup_kubectl_eksctl.sh

# Set execute permissions for setup eks cluster script
chmod +x setup_eks_cluster.sh

# Run setup eks cluster script
echo "Executing setup eks cluster script..."
./setup_eks_cluster.sh

# Set execute permissions to setup application script
chmod +x setup_application.sh

# Run setup application script
echo "Executing setup application script..."
./setup_application.sh


echo "All scripts executed successfully."
