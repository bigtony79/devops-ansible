# Configure Dynamic Inventory

## Overview

This lab demonstrates how to use Ansible's AWS EC2 Dynamic Inventory plugin to automatically discover and manage AWS EC2 instances without maintaining a static inventory file. Instead of manually updating server IP addresses in an Ansible hosts file, Ansible queries AWS directly and dynamically builds its inventory based on the EC2 instances available in the AWS account.

The objective of this project is to gain hands-on experience with dynamic inventory management and cloud automation. Terraform is used to provision multiple EC2 instances, while Ansible leverages the AWS EC2 plugin to discover those instances and execute playbooks against them. This approach improves scalability, reduces manual administration, and ensures that infrastructure changes are automatically reflected in Ansible's inventory.


## Technologies used
* Ansible
* Terraform
* AWS

## Project Description
* Create EC2 instance with Terraform
* Write Ansible AWS EC2 Plugin to dynamically set inventory of EC2 servers that Ansible should manage, instead of hard-coding server addresses in Ansible inventory file

## Pre-requisites

Before starting this lab, ensure you have:
 
- AWS Account
- Terraform installed
- Ansible installed
- AWS CLI installed and configured
- IAM credentials with permissions to query EC2 resources
- SSH key pair for EC2 access
- Python packages required by the AWS EC2 plugin

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

### 4. Save the docker-compose.yaml file in the Ansible control node
Save the docker-compose.yaml file in the defined location_source directory of the Ansible control node
 
### 5. Create AWS EC2 instance by running terraform
```
  terraform init
```
```
  terraform plan
```
```
  terraform apply
```

### 6. Configure Ansible Dynamic Inventory plugin
This configuration enables Ansible to query AWS directly and dynamically build an inventory of EC2 instances instead of relying on a statically maintained hosts file.

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

### 7. Configure Ansible to use dynamic inventory
* Because the inventory is generated dynamically, the playbook can target either all discovered hosts or the AWS EC2 inventory group created by the plugin:
```
  hosts: all
```
or
```
  hosts: aws_ec2
```

* To globally set the username and private key to allow Ansible to access the remote EC2 instances, we can add the following to the ansible.cfg file:
```
  remote_user =ec2-user
  private_key_file = ~/.ssh/id_ed25519
```

### 8. Run Ansible playbook
We do not need to add hosts file now that we are using dynamic inventory plugin
```
  ansible-playbook deploy_docker_tf_hosts.yaml
```
Please note that we added ```inventory = inventory_aws_ec2.yaml``` in the ansible.cfg file, so don't need to specify the inventory file in the ansible-playbook command.

### 9. Destroy AWS infrastructure
Don't forget to run ```terraform destroy``` after you are done with the project.

## Learning Outcomes 
By completing this lab, you will learn how to: 
- Configure the AWS EC2 Dynamic Inventory plugin
- Replace static inventories with dynamically discovered hosts
- Integrate Terraform and Ansible in cloud environments
- Manage multiple EC2 instances efficiently
- Configure Ansible authentication globally
- Scale Ansible automation without inventory maintenance


  


