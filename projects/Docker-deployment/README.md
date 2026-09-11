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

### 2. Define Ansible Variables file
Create your own ansible variable file (such as vars-file.yaml) and define the following key:value pairs:
```
 docker_compose_dir: DOCKER_COMPOSE_DIRECTORY
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

### 5. Update the hosts file with Public IPv4 Address of the EC2 instance
Copy the public IPv4 IP address of the EC2 instance and update the Ansible hosts file. 
Example:
```
 [docker_server]
 EC2_Public_IPv4_Address ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/<private_key>
 ```
**Note** - Unlike Digital Ocean droplet where we used root as the ansible_user, we will need to use "ec2-user" as the ansible-user for EC2!

### 6. Run Ansible playbook which refers to the external hosts file which was updated from step #5
```
 ansible-playbook -i hosts deploy_docker_ext_hosts.yaml
```



