# Configure Dynamic Inventory

## Overview

* We will create 3 EC2 Instances with Terraform
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

### 1. Create 3 EC2 Instances with Terraform
```
resource "aws_instance" "myapp_server_one" {
  ami = data.aws_ami.amazon_linux_image.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.myapp-subnet.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = aws_key_pair.myapp-keypair.key_name
  tags = {
    Name: "${var.env_prefix}-server-1"
  }
}


resource "aws_instance" "myapp_server_two" {
  ami = data.aws_ami.amazon_linux_image.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.myapp-subnet.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = aws_key_pair.myapp-keypair.key_name
  tags = {
    Name: "${var.env_prefix}-server-2"
  }
}


resource "aws_instance" "myapp_server_three" {
  ami = data.aws_ami.amazon_linux_image.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.myapp-subnet.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = aws_key_pair.myapp-keypair.key_name
  tags = {
    Name: "${var.env_prefix}-server-3"
  }
}


resource "aws_instance" "myapp_server_four" {
  ami = data.aws_ami.amazon_linux_image.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.myapp-subnet.id
  vpc_security_group_ids = [aws_security_group.myapp-sg.id]
  availability_zone = var.avail_zone
  associate_public_ip_address = true
  key_name = aws_key_pair.myapp-keypair.key_name
  tags = {
    Name: "${var.env_prefix}-server-4"
  }
}
'''

