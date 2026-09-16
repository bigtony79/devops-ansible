# Configure Dynamic Inventory

## Overview

* We will create 4 EC2 Instances with Terraform
* Connect to these servers with Ansible without hard-coding the IP addresses

## Technologies used
* Ansible
* Terraform
* AWS

## Project Description
* Create EC2 instance with Terraform
* Write Ansible AWS EC2 Plugin to dynamically set inventory of EC2 servers that Ansible should manage, instead of hard-coding server addresses in Ansible inventory file

## Pre-requisites

## Steps

### 1. Enable Public DNS Name in VPC
In main.tf, we will add ```enable_dns_hostnames = true``` in the VPC resource block:
```
  resource "aws_vpc" "myapp-vpc" {
  cidr_block =  var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}
```

### 2. Create and define terraform.tvars file
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

### 3. Define Ansible Variables file
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

### 5. Configure Ansible Dynamic Inventory plugin
This will allow Ansible to connect to AWS and fetch required information

#### a.  Enable plugin in ansible configuration file
Modify the ansible.cfg file by including the following:
```
  enable_plugins = aws_ec2
```
#### b. Create plugin configuration file
* Config file must end with "aws_ec2.yaml". In our case, it will be inventory_aws_ec2.yaml.
  ```
    ---
    plugin: aws_ec2
    regions:
      - us-east-1
  ```
* With this configuration, we can execute the plugin separately for testing purposes without playbook configuration
```
  ansible-inventory -i inventory_aws_ec2.yaml --list 
```
Please note that we are not connecting to these EC2 Servers when we run the above command - we are just connecting to the Cloud Account and listing out information of the EC2 Instances.
* To view a cleaner output which just lists the IP addresses instead of the full information for the 4 instances
```
  ansible-inventory -i inventory_aws_ec2.yaml --graph
```

### 6. Configure Ansible to use dynamic inventory
* In the Ansible playbook, we can set the value for **hosts** to either ```hosts: all``` or ```hosts:aws_ec2```.
* To globally set the username and private key to allow Ansible to access the remote EC2 instances, we can add the following to the ansible.cfg file:
```
  remote_user =ec2-user
  private_key_file = ~/.ssh/id_ed25519
```

### 7. Run Ansible playbook
We do not need to add hosts file now that we are using dynamic inventory plugin
```
  ansible-playbook deploy_docker_tf_hosts.yaml
```
Please note that we added ```inventory = inventory_aws_ec2.yaml``` in the ansible.cfg file, so don't need to specify the inventory file in the ansible-playbook command.




  


