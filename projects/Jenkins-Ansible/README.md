# Ansible integration with Jenkins

## Overview

This project demonstrates how to integrate Jenkins and Ansible to automate server configuration as part of a CI/CD pipeline. Jenkins acts as the orchestration platform and remotely executes Ansible playbooks on a dedicated Ansible Control Node, which in turn manages multiple AWS EC2 instances. 

The objective is to build an end-to-end automation workflow where infrastructure and configuration tasks can be executed directly from a Jenkins pipeline. The pipeline securely transfers playbooks, configuration files, and SSH credentials to the Ansible Control Node, installs required dependencies, and executes Ansible playbooks that configure and manage target EC2 instances.

## Technologies used
* Ansible
* Jenkins
* DigitalOcean
* AWS
* Boto3
* Docker
* Java
* Maven
* Linux
* Git

## Project Description
* Create and configure a dedicated server for Ansible Control Node
* Write Ansible Playbook, which configures 2 EC2 Instances
* Add ssh key file credentials in Jenkins for Ansible Control Node server and Ansible Managed Node servers
* Configure Jenkins to execute the Ansible Playbook on remote Ansible Control Node server as part of the CI/CD pipeline
* So the Jenkinsfile configuration will do the following:
  - Connect to the remote Ansible Control Node server
  - Copy Ansible playbook and configuration files to the remote Ansible Control Node server
  - Copy the ssh keys for the Ansible Managed Node servers to the Ansible Control Node server
  - Install Ansible, Python3 and Boto3 on the Ansible Control Node server
  - With everything installed and copied to the remote Ansible Control Node server, execute the playbook remotely on that Control Node that will configure the 2 EC2 Managed Nodes

## Prerequisites
Before starting this lab, ensure you have the following:
 
- Jenkins installed and operational
- DigitalOcean account
- AWS account with permissions to create and manage EC2 resources
- Terraform installed
- SSH key pairs for:
  - Jenkins → Ansible Control Node access
  - Ansible Control Node → EC2 Managed Nodes access
- Git repository containing the Ansible playbooks and Jenkinsfile
- Basic familiarity with Jenkins Pipelines and Ansible

### Jenkins Requirements

Install the following Jenkins plugins:
 
- SSH Agent Plugin
- SSH Pipeline Steps Plugin
- Git Plugin
- Pipeline Plugin
 
### Ansible Control Node Requirements
 
The Ansible Control Node should have the following software installed:
 
- Ansible
- Python 3
- boto3
- botocore
- AWS CLI
 
Verify the installations:
 
```bash
ansible --version
``` 
```bash
python3 --version
``` 
```bash
aws --version
```
 
### AWS Credentials Configuration
 
Configure AWS credentials on the Ansible Control Node:
 
```bash
mkdir -p ~/.aws
```
 
Create the credentials file:
 
```bash
vim ~/.aws/credentials
```
 
Add the AWS access key and secret key for a user with permissions to manage EC2 resources.
 
### Jenkins Credentials Configuration
 
Store the following credentials in Jenkins:
 
- SSH private key for Ansible Control Node access
- SSH private key for EC2 Managed Nodes access
- Any AWS credentials required by the pipeline
 
Navigate to:
 
```text
Manage Jenkins → Credentials → System → Global Credentials
```
 
and create the appropriate credential entries before executing the pipeline.


## Steps

### 1. Create a DigitalOcean Droplet for Ansible Control Node and install ansible
Follow the documentation in docs.ansible.com to install ansible on the newly created Droplet

### 2. Install boto3 and botocore packages on the Ansible Control Node
This is required for Ansible to allow execute certain tasks on AWS EC2 instances
```
apt install python3-boto3
apt install python3-botocore
```
### 3. Configure AWS Credentials with Ansible Control Node
```
  mkdir .aws
  cd .aws
  vim credentials
```
Enter and save the credentials for the AWS user in the **credentials** file.

### 4. Create 2 EC2 Instances to be managed by Ansible
Create a terraform variables .tvars file and define the key value pairs
```
  vpc_cidr_block = <VPC_MAIN_CIDR_BLOCK>
  subnet_cidr_block = <SUBNET_CIDR_BLOCK>
  avail_zone = <AVAILABILITY_ZONE>
  env_prefix = <ENVIRONMENT_PREFIX>
  my_ip = <ANSIBLE_SERVER_IP_ADDRESS>
  instance_type = <DESIRED_INSTANCE_TYPE>
  public_key_location = <PUBLIC_KEY_LOCATION>
  image_name = "al2023-ami-2023*"
```
Run terraform to create the 2 EC2 Instances:
```
  terraform init
  terraform plan
  terraform apply
```

### 5. JenkinsFile: Copy files from Jenkins to Ansible Control Node
a. Save SSH Credentials in Jenkins under **Manage Jenkins -> Credentials -> System -> Global Credentials**

Save Ansible and AWS Server credentials 
<INSERT SCREENSHOTS>

b. Create Jenkins Pipeline
<INSERT SCREENSHOTS>

c. Install sshagent plugin in Jenkins
This will allow  you to securely pass SSH credentials stored in Jenkins into a pipeline, giving your steps (like shell scripts or Ansible playbooks) authenticated SSH access to remote servers without hardcoding private keys into your code or workspace.
<INSERT SCREENSHOT>

d. Install **SSH Pipeline Steps** plugin in Jenkins
Enables us to execute command line commands on a remote server such as Ansible. In other words, it allows Jenkins to execute remote commands on Ansible server



## Learning Outcomes

- Integrate Ansible into Jenkins pipelines 
- Configure a dedicated Ansible Control Node 
- Manage AWS EC2 instances with Ansible 
- Securely store and use SSH credentials in Jenkins 
- Execute remote commands through Jenkins 
- Automate server configuration as part of a CI/CD workflow 
- Build scalable infrastructure automation solutions


