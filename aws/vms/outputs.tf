# Return EC2 instances infomation
output "ec2-instance-id" {
    value = aws_instance.nodes[*].id
}

output "ec2-public-ip" {
    value = aws_instance.nodes[*].public_ip
}

output "ec2-private-ip" {
    value = aws_instance.nodes[*].private_ip
}