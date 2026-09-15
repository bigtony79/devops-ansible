# Ansible Integration in Terraform

## Overview
This project will demonstrate the use of ***terraform_data*** module which will eliminate manual tasks of obtaining IP address of an EC2 instance, updating hosts and then executing ansible playbook. Instead everything will be automated from the Terraform script itself.

## Technologies used
* Ansible
* Terraform
* AWS
* Docker
* Linux

## Project Description
* Create Ansible Playbook for Terraform integration
* Adjust Terraform configuration to execute Ansible Playbook automatically, so once Terraform provisions a server, it executes an Ansible playbook that configures the server

## Prerequisites
Before starting this lab, ensure you have:
- AWS Account
- Terraform installed on the local machine
- Ansible installed on the control node
- An SSH key pair for EC2 access
- Docker Hub account (if pulling private images)
- A valid docker-compose.yaml file

## Steps
### 1. Create and define terraform.tvars file
Define terraform.tvars file before running terraform
```
  vpc_cidr_block = DESIRED_VPC_CIDR_BLOCK
  subnet_cidr_block = SUBNET_CIDR_BLOCK
  avail_zone = AVAIL_ZONE
  env_prefix = DESIRED_PREFIX
  my_ip = IP_ADDRESS 
  instance_type = DESIRED_INSTANCE_TYPE
  public_key_location = PUBLIC_KEY_FILE_LOCATION
  image_name = "al2023-ami-2023*"
```
Make sure that you add terraform.tvars in .gitignore file

### 2. Define Ansible Variables file
Create your own ansible variable file (such as vars-file.yaml) and define the following key:value pairs:
```
 docker_compose_dir: TARGET_DOCKER_COMPOSE_DIRECTORY_EC2_INSTANCE
 location_source: SOURCE_DIRECTORY_ANSIBLE_CONTROL_NODE
 location_target: TARGET_DIRECTORY_EC2_INSTANCE
 docker_username: DOCKERHUB_USER_NAME
 docker_password: PASSWORD_OR_PAT
```
 Make sure that you add this file in .gitignore! 

### 3. Save the docker-compose.yaml file in the Ansible control node
Save the docker-compose.yaml file in the defined location_source directory of the Ansible control node
 
### 4. Create AWS EC2 instance by running terraform
```
  terraform init
```
```
  terraform plan
```
```
  terraform apply
```
### 5. Terraform 
Unlike the Docker deployment project, we are not going to manually capture the public IP address of the EC2 instance and update the hosts file as we are using Terraform to provision the server and then run the playbook on the newly created server.  The following code within the *main.tf* file will fulfill this requirement:
```
  resource "terraform_data" "ansible_run" {
  triggers_replace = [
    aws_instance.myapp_server_one.public_ip
  ]
  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.myapp_server_one.public_ip}, --private-key ${var.ssh_private_key_location} --user ec2-user deploy_docker_tf_hosts.yaml"
  }
}
```





