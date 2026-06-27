# key pair (login)

resource "aws_key_pair" "my_key" {
  key_name   = "terra-tws-proj-ec2"
  public_key = file("terra-tws-proj-ec2.pub")

}

# vpc and security groups (to create vpc , secur grps required)
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security" {
  name        = "automated-sg"
  description = " this generates automated sg"
  vpc_id      = aws_default_vpc.default.id #interpolation

  #inbound rules

  #outbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH OPEN"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP OPEN"
  }

  egress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1" #means all
    description = "all access open to outbound"
  }

  tags = {
    Name = "automated_sg"
  }
}


# ec2 instance

resource "aws_instance" "my_instance" {
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security.name]
  instance_type   = var.ec2-instance-type
  ami             = var.ec2-ami-id #ubuntu
  user_data = file("install_nginx.sh")
  root_block_device {
    volume_size = var.ec2-rbd-size
    volume_type = "gp3"
  }

  tags = {
    Name = "terraform-automated-ec2-instance-project-tws"
  }

}