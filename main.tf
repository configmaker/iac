provider "aws" {
  region = var.aws_region
}

# Create VPC and subnets
# Provide arguments in terraform.tfvars file
module "vpc" {
  source              = "/Users/I501430/Documents/mywork/terraform/aws/network"
  aws_region          = var.aws_region
  project_name        = var.project_name
  enable_dns          = var.enable_dns
  public_ip_on_launch = var.public_ip_on_launch
  vpc_cidr            = var.vpc_cidr
  vpc_subnet_count    = var.vpc_subnet_count
}

# Create EC2 instances in the VPC
module "ec2" {
  source = "/Users/I501430/Documents/mywork/terraform/aws/vms"
  ec2_instance_count = var.ec2_instance_count
  instance_type= var.instance_type
  subnets-id = module.vpc.subnets-id
  security-group-id = module.vpc.security-group-id
}
