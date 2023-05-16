variable "project_name" {
  type        = string
  description = "Tag info"
  default     = "poc-tag"
}

variable "aws_region" {
  description = "Workspace Region"
  type        = string
  default     = "us-west-2"
}

variable "enable_dns" {
  type        = bool
  description = "Enable DNS hostname in VPC"
  default     = true
}

variable "public_ip_on_launch" {
  type        = bool
  description = "Map a public IP address on launch"
  default     = true
}

variable "vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

variable "vpc_subnet_count" {
  type    = number
  default = 2
}
