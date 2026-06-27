# key pair (login)

resource "aws_key_pair" "my_key" {
  key_name   = "${var.env}-modules-terra-tws-proj-ec2"
  public_key = file("terra-tws-proj-ec2.pub")

  tags = {
    Name = "${var.env}-modules-terra-tws-proj-ec2"
    Environment = var.env
  }
}

# vpc and security groups (to create vpc , secur grps required)
resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "my_security" {
  name        = "${var.env}-module-infra-app-sg"
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
    Name = "${var.env}-automated_sg"
  }
}


# ec2 instance

resource "aws_instance" "my_instance" {
  # for_each = tomap({
  #   tws-automate-micro = "t2.micro",
  #   tws-automate-medium = "t2.medium"
  # })
  count = var.instance_count
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security.name]
  instance_type   = var.instance_type
  ami             = var.ami_id #ubuntu
  #user_data = file("install_nginx.sh")
  root_block_device {
    volume_size = var.env == "prd"? 20 : 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.env}-terraform-automated-ec2-instance-project-tws" #each.key
    Environment = var.env
  }

}