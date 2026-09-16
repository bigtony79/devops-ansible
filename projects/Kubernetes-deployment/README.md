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

### 4. Run Ansible playbook
```
  ansible-playbook deploy-to-k8s.yaml
```

### 5. Connect to the EKS cluster
* On the terminal, set the kubeconfig to point to the EKS cluster
  ```
    export KUBECONFIG = kubeconfig_myapp-eks-cluster
  ```

* Check for the newly created namespace:
  ```
  kubectl get namespace
  ```
  <INSERT OUTPUT>

* Check status of pods in namespace **my-app**
    ```
    kubectl get pod -n my-app
    ```
    <INSERT OUTPUT>
* Check status of service
    ```
      kubectl get svc -n my-app
    ```
    <INSERT OUTPUT>
* Access the nginx web server
  <INSERT OUTPUT>
  
### 6. Minor improvement of use of kubeconfig
Instead of saving the kubeconfig entry in multiple tasks within the playbook, you can define it once and use it for all the tasks.
```
  export K8S_AUTH_KUBECONFIG=kubeconfig_myapp-eks-cluster
```
You can remove the reference of kubeconfig entries in the tasks from the playbook.
 
### 7. Destroy the EKS Cluster
Once you are done with the project, you can destroy the cluster to avoid additional costs.
```
  terraform destroy
```
  
    
  
