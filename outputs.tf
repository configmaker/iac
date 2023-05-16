# print public ip addresses of new created instances
output "ec2-public-ip" {
  value = module.ec2.ec2-public-ip
}

# show the command to ssh to the 1st ec2 instance
output "ssh_command" {
  value = "ssh -i ~/.ssh/poc-tag-ec2-key.pem ec2-user@${module.ec2.ec2-public-ip[0]}"
}