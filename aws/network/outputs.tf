# return VPC information
output "region" {
  value = var.aws_region
}

output "vpc-id" {
  value = aws_vpc.vpc-poc.id
}

output "subnets-id" {
  value = aws_subnet.subnets[*].id
}

output "security-group-id" {
  value = aws_security_group.sg-vpc-poc.id
}