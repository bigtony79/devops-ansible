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
Enter and save the credentials for the AWS user in the credentials file.


## Learning Outcomes


