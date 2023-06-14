# Get AMI information
data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Define the ssh key pair for EC2
resource "aws_key_pair" "poc-ec2-keypair" {
  key_name   = "${var.project_name}-ec2-keypair"
  public_key = file("~/.ssh/poc-tag-ec2-key.pub")
}

# Create EC2 instances
resource "aws_instance" "nodes" {
  count           = var.ec2_instance_count
  ami             = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type   = var.instance_type
  subnet_id       = var.subnets-id[count.index]
  security_groups = [var.security-group-id]
  key_name        = aws_key_pair.poc-ec2-keypair.key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("~/.ssh/poc-tag-ec2-key.pem")

  }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum update -y",
  #     "sudo yum install ec2-instance-connect",
  #   ]
  # }

  tags = {
    Name = "node${count.index}"
  }
}
