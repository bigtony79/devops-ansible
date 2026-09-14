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

```
ansible-playbook -i hosts deploy_docker_ext_hosts.yaml
```

### 7. Verify Docker deployment
Verify that Docker is running on the EC2 instance
```
   sudo systemctl status docker
   [ec2-user@ip-10-16-26-59 ~]$ sudo systemctl status docker
● docker.service - Docker Application Container Engine
     Loaded: loaded (/usr/lib/systemd/system/docker.service; enabled; preset: disabled)
     Active: active (running) since Mon 2026-09-14 21:47:04 UTC; 7min ago
TriggeredBy: ● docker.socket
       Docs: https://docs.docker.com
    Process: 29025 ExecStartPre=/bin/mkdir -p /run/docker (code=exited, status=0/SUCCESS)
    Process: 29026 ExecStartPre=/usr/libexec/docker/docker-setup-runtimes.sh (code=exited, status=0/SUCCESS)
   Main PID: 29027 (dockerd)
      Tasks: 52
     Memory: 65.0M
        CPU: 45.429s
     CGroup: /system.slice/docker.service
             ├─29027 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --default-ulimit nofile=32768:65536
             ├─30448 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 8083 -container-ip 172.18.0.2 -container-port 80
             ├─30455 /usr/bin/docker-proxy -proto tcp -host-ip :: -host-port 8083 -container-ip 172.18.0.2 -container-port 80
             ├─30495 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 3306 -container-ip 172.18.0.4 -container-port 3306
             └─30502 /usr/bin/docker-proxy -proto tcp -host-ip :: -host-port 3306 -container-ip 172.18.0.4 -container-port 3306

Sep 14 21:47:03 ip-10-16-26-59.ec2.internal systemd[1]: Starting docker.service - Docker Application Container Engine...
Sep 14 21:47:03 ip-10-16-26-59.ec2.internal dockerd[29027]: time="2026-09-14T21:47:03.764146185Z" level=info msg="Starting up"
Sep 14 21:47:03 ip-10-16-26-59.ec2.internal dockerd[29027]: time="2026-09-14T21:47:03.816455792Z" level=info msg="Loading containers: start."
Sep 14 21:47:04 ip-10-16-26-59.ec2.internal dockerd[29027]: time="2026-09-14T21:47:04.311766108Z" level=info msg="Loading containers: done."
Sep 14 21:47:04 ip-10-16-26-59.ec2.internal dockerd[29027]: time="2026-09-14T21:47:04.339680701Z" level=info msg="Docker daemon" commit=6fdf0a6 containerd-snapshotter=false storage-driver=overlay2 version=25.>
Sep 14 21:47:04 ip-10-16-26-59.ec2.internal dockerd[29027]: time="2026-09-14T21:47:04.339927548Z" level=info msg="Daemon has completed initialization"
Sep 14 21:47:04 ip-10-16-26-59.ec2.internal dockerd[29027]: time="2026-09-14T21:47:04.383503696Z" level=info msg="API listen on /run/docker.sock"
Sep 14 21:47:04 ip-10-16-26-59.ec2.internal systemd[1]: Started docker.service - Docker Application Container Engine.
Sep 14 21:47:46 ip-10-16-26-59.ec2.internal dockerd[29027]: time="2026-09-14T21:47:46.972909542Z" level=info msg="ignoring event" container=ecd220a7a795cdbe32c30e123dbebb22f0bb954bff6b10600aafec06c507c90d mod>
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


