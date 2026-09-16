provider "aws" {
    region = "us-east-1"
}

variable vpc_cidr_block {}
variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}
variable cluster_name {}

data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
    source = "terraform-aws-modules/vpc/aws"
    name = var.cluster_name

    cidr = var.vpc_cidr_block
    azs = data.aws_availability_zones.azs.names
    private_subnets = var.private_subnet_cidr_blocks
    public_subnets = var.public_subnet_cidr_blocks
    enable_nat_gateway = true
    single_nat_gateway = true
    enable_dns_hostnames = true

    tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }

    public_subnet_tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/elb" = 1

    }

    private_subnet_tags = {
        "kubernetes.io/cluster/${var.cluster_name}" = "shared"
        "kubernetes.io/role/internal-elb" = 1
   
    }
    
}
