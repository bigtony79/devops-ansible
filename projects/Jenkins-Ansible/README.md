# Ansible integration with Jenkins

## Overview

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
* Create and configure a dedicated server for Jenkins
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


