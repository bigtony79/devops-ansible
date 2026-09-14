# Automate Docker Deployment using Ansible

## Overview
This lab demonstrates how to use **Terraform** and **Ansible** together to automate the provisioning and configuration of a Docker-based application environment on **AWS**. Terraform is used to create the required AWS infrastructure, while Ansible is used to configure the server, install Docker components, and deploy containerized applications.
...

The objective of this project is to gain hands-on experience with Infrastructure as Code (IaC) and configuration management by building a fully automated deployment workflow. The process begins with provisioning an AWS EC2 instance using Terraform, followed by configuring the instance through Ansible to install Docker and Docker Compose, transfer application configuration files, and launch containers using a Docker Compose stack.

## Technologies used
* Ansible
* AWS
* Docker
* Linux
* Terraform

## Project Description
* Create AWS EC2 Instance with Terraform
* Configure Inventory file to connect to AWS EC2 instance
* Write Ansible Playbook that will perform the following:
   - Install Docker and Docker Compose
   - Copy docker-compose file to server
   - Start Docker containers

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

### 5. Update the hosts file with Public IPv4 Address of the EC2 instance
Copy the public IPv4 IP address of the EC2 instance and update the Ansible hosts file. 
Example:
```
 [docker_server]
 EC2_Public_IPv4_Address ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/<private_key>
 ```
**Note** - Unlike Digital Ocean droplet where we used root as the ansible_user, we will need to use "ec2-user" as the ansible-user for EC2!

### 6. Run Ansible playbook 
Execute the playbook using the inventory file updated in Step 5
**ansible-playbook -i hosts deploy_docker_ext_hosts.yaml**
```
dataeng@ubuntu-gmktec:~/ansible-projects/docker$ ansible-playbook -i hosts deploy_docker_ext_hosts.yaml

PLAY [Install Docker and Docker Compose] ************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
[WARNING]: Host '54.162.181.118' is using the discovered Python interpreter at '/usr/bin/python3.9', but future installation of another Python interpreter could cause a different interpreter to be discovered. See https://docs.ansible.com/ansible-core/2.21/reference_appendices/interpreter_discovery.html for more information.
ok: [54.162.181.118]

TASK [Install Docker] *******************************************************************************************************************************************************************************************
changed: [54.162.181.118]

PLAY [Download and Install Docker Compose] **********************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [54.162.181.118]

TASK [Create directory for docker-compose] **********************************************************************************************************************************************************************
changed: [54.162.181.118]

TASK [Get architecture of remote host] **************************************************************************************************************************************************************************
changed: [54.162.181.118]

TASK [Download docker-compose] **********************************************************************************************************************************************************************************
changed: [54.162.181.118]

TASK [Verify docker-compose installation] ***********************************************************************************************************************************************************************
changed: [54.162.181.118]

TASK [Display docker-compose version] ***************************************************************************************************************************************************************************
ok: [54.162.181.118] => {
    "msg": "Docker Compose version installed: Docker Compose version v5.5.0"
}

PLAY [Add ec2-user to docker group] *****************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [54.162.181.118]

TASK [Add ec2-user to docker group] *****************************************************************************************************************************************************************************
changed: [54.162.181.118]

TASK [Reconnect to server session] ******************************************************************************************************************************************************************************

PLAY [Start Docker service] *************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [54.162.181.118]

TASK [Start Docker service] *************************************************************************************************************************************************************************************
changed: [54.162.181.118]

PLAY [Test docker pull] *****************************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [54.162.181.118]

TASK [Pull hello-world image] ***********************************************************************************************************************************************************************************
changed: [54.162.181.118]

PLAY [Start docker containers] **********************************************************************************************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************************************************************************************************************
ok: [54.162.181.118]

TASK [Copy docker compose file to remote host] ******************************************************************************************************************************************************************
changed: [54.162.181.118]

TASK [Docker login] *********************************************************************************************************************************************************************************************
changed: [54.162.181.118]

TASK [Start docker containers using docker-compose] *************************************************************************************************************************************************************
[WARNING]: Docker compose: unknown None: /home/ec2-user/docker-compose.yaml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion
changed: [54.162.181.118]

PLAY RECAP ******************************************************************************************************************************************************************************************************
54.162.181.118             : ok=18   changed=11   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0


```

### 7. Verify Docker deployment
Verify that Docker is running on the EC2 instance
```
   sudo systemctl status docker
```

List running containers
```
   docker ps
```

Verify the Docker Compose application:
```
   docker compose ps
```
if all containers show a status of "Up", the deployment was successful.

## Learning Outcomes
- AWS infrastructure is provisioned using Terraform.
- An EC2 instance is created and accessible through SSH.
- Docker and Docker Compose are installed on the instance.
- The docker-compose.yaml file is copied to the server.
- Docker containers are started automatically.
- The application is running and accessible from the deployed environment.


