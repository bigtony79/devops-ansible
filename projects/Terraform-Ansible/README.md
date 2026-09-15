# Ansible Integration in Terraform

## Overview
This project demonstrates how to integrate **Ansible** with **Terraform** using the **terraform_data** resource to automate server provisioning and configuration. Traditionally, after Terraform provisions an AWS EC2 instance, additional manual steps are required to obtain the server's public IP address, update the Ansible inventory file, and execute an Ansible playbook.

Using Terraform's `terraform_data` resource and a `local-exec` provisioner, these manual tasks are eliminated. Once Terraform successfully provisions the EC2 instance, it automatically invokes an Ansible playbook that connects to the newly created server and performs the required configuration tasks. 

This approach demonstrates how Infrastructure as Code (IaC) and Configuration Management can work together to provide a fully automated deployment workflow, from infrastructure provisioning to application deployment.

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
### 5. Configure Terraform to Execute Ansible Automatically
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
Explanation: 
- `aws_instance.myapp_server_one.public_ip` is used as a trigger, causing the resource to execute whenever the EC2 instance changes.
- The `local-exec` provisioner executes an Ansible playbook from the Terraform execution environment.
- The generated EC2 public IP address is passed directly to Ansible as an inline inventory.
- The `--private-key` parameter allows Ansible to authenticate using SSH.
- The `--user ec2-user` parameter specifies the default AWS Linux user account.

  
**Note:** The trailing comma after the IP address is required. Without it, Ansible interprets the value as a filename rather than an inventory host.

## Learning Outcomes
 
By completing this lab, you will learn how to: 
- Provision AWS infrastructure using Terraform
- Use Terraform variables and tfvars files
- Integrate Terraform and Ansible workflows
- Dynamically pass infrastructure information to Ansible
- Eliminate manual inventory management
- Configure Linux servers using Ansible
- Deploy Docker-based applications automatically after provisioning
- Implement end-to-end Infrastructure as Code (IaC) automation




