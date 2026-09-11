# Automate Docker Deployment using Ansible

## Overview

## Technologies used
* Ansible
* AWS
* Docker
* Linux
* Terraform

## Project Description
* Create AWS EC2 Instance with Terraform
* Configure Inventory file to connect to AWS EC2 instnace
* Write Ansible Playbook that will perform the following:
 - Install Docker and docker-compose
 - Copy docker-compose file to server
 - Start Docker containers

## Steps
### 1. Create and define terraform.tvars file
Define terraform.tvars file before running terraform
```
  vpc_cidr_block = DESIRED_VPC_CIDR_BLOCK
  subnet_cidr_block = SUBNET_CIDR_BLOCK
  avail_zone = AVAIL_ZONE
  env_prefix = DESIRED_PREFIX
  my_ip = IP_ADDRRESS 
  instance_type = DESIRED_INSTANCE_TYPE
  public_key_location = PUBLIC_KEY_FILE_LOCATION
  image_name = "al2023-ami-2023*"
```
Make sure that you add terraform.tvars in .gitignore file

### Create AWS EC2 instance by running terraform
```
  terraform init
```
```
  terraform plan
```
```
  terraform apply
```

`


