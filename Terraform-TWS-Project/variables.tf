variable "ec2-instance-type" {
  default = "t3.micro"
  type = string
}

variable "ec2-ami-id" {
  default = "ami-091138d0f0d41ff90" #ubuntu
  type = string
}

variable "ec2-rbd-size" {
    default = 15
    type = number
}