provider "aws" {
  
}

variable vpc_cidr_block {}
variable subnet_cidr_block {}
variable avail_zone {}
variable env_prefix {}
variable my_ip {}
variable instance_type {}
variable public_key_location {}
variable image_name {}
variable ssh_private_key_location {}

resource "aws_vpc" "myapp-vpc" {
  cidr_block =  var.vpc_cidr_block
  enable_dns_hostnames = true
  tags = {
    Name: "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "myapp-subnet" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name: "${var.env_prefix}-subnet"
  }
}

resource "aws_internet_gateway" "myapp-igw" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name: "${var.env_prefix}-igw"
  }
}

resource "aws_default_route_table" "myapp-rtb" {
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-igw.id
  }
  tags = {
    Name: "${var.env_prefix}-main-rtb"
  }
}

resource "aws_security_group" "myapp-sg" {
  name = "${var.env_prefix}-sg"
  description = "Security group for ${var.env_prefix} environment to allow for connectivity to the EC2 instance"
  vpc_id = aws_vpc.myapp-vpc.id

  tags = {
    Name: "${var.env_prefix}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "myapp-sg-ingress" {
  security_group_id = aws_security_group.myapp-sg.id
  cidr_ipv4 = var.my_ip  
  from_port = 22 #Comment: This allows SSH access from the specified IP address
  to_port = 22 #Comment: This allows SSH access from the specified IP address
  ip_protocol = "tcp"
  
  
}

resource "aws_vpc_security_group_egress_rule" "myapp-sg-egress" {
  security_group_id = aws_security_group.myapp-sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_key_pair" "myapp-keypair" {
  key_name = "${var.env_prefix}-keypair"
  public_key = file(var.public_key_location)
}

data "aws_ami" "amazon_linux_image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.image_name]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]    
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}
 
 output "aws_ami_id" {
  value = data.aws_ami.amazon_linux_image.id
  description = "The ID of the Amazon Linux 2 AMI"
 }

output "public_ip" {
  value = aws_instance.myapp_server_one.public_ip
  description = "The public IP address of the EC2 instance"
}

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

  #provisioner "local-exec" {
  # local-exec provisioner to run Ansible playbook after instance creation.  
  # Leaving this commented out for reference. The terraform_data resource will be used to trigger the Ansible playbook when the public IP of the instance changes.

  #  command = "ansible-playbook -i ${self.public_ip}, --private-key ${var.ssh_private_key_location} --user ec2-user deploy_docker_tf_hosts.yaml"

  #}
}

resource "terraform_data" "ansible_run" {
  triggers_replace = [
    aws_instance.myapp_server_one.public_ip
  ]

  provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.myapp_server_one.public_ip}, --private-key ${var.ssh_private_key_location} --user ec2-user deploy_docker_tf_hosts.yaml"
  }

}



 
 





































