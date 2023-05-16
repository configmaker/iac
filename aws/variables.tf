
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

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_instance_count" {
  type    = number
  default = 2
}

variable "resource_stage" {
  type    = list(string)
  default = ["test", "test", "prod"]
}



variable "environment_name" {
  type        = list(string)
  description = "Tag info"
  default     = ["test", "test", "prod"]
}

variable "team_name" {
  type        = string
  description = "Tag info"
  default     = "sdo"
}
