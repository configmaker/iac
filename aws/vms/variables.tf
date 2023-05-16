variable "aws_region" {
  type = string
  default = "us-west-2"
}

variable "project_name" {
  type = string
  default="poc"
}

variable "vps_subnet_count" {
  type    = number
  default = 2
}

variable "subnets-id" {
  type = list(string)
}

variable "security-group-id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_instance_count" {
  type    = number
  default = 2
}