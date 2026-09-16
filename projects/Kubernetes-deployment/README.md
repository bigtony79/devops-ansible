# Automate Kubernetes Deployment using Ansible

## Overview


## Technologies used
* Ansible
* Terraform
* Kubernetes
* AWS EKS
* Python
* Linux

## Project Description
* Create EKS cluster with Terraform
* Write Ansible playbook to deploy application in new K8s namespace
  
## Steps

### 1. Create the EKS Cluster using Terraform
```
  terraform init
```
```
  terraform plan
```
```
  terraform apply
```
<INSERT SCREENSHOT of EKS Cluster>

### 2. Create a kubeconfig file
We will need to create a kubeconfig file to allow Ansible to connect to the EKS cluster
```
  aws eks update-config --region us-east-1 --name myapp-eks-cluster --kubeconfig kubeconfig_myapp-eks-cluster
```

### 3. Ansible playbook to deploy app to K8s
The playbook consists of 1 play with the following tasks:
* Create a K8s namespace in the EKS cluster
* Deploy the nginx app using the Kubernetes manifest file - **nginx-config.yaml**
* hosts is set to ```localhost``` - Ansible will connect to the EKS cluster

We need to make sure the following pre-requisites for the module **kubernetes.core.k8s** are installed on the Ansible control node before the running the playbook:
* python >= 3.9
* kubernetes >= 24.2.0
* PyYAML >= 3.11
* jsonpatch

You can use pip3 to install the above packages. For example, to install pyyaml in your user directory instead of system directory:
```
  pip3 install pyyaml --user
```



  
