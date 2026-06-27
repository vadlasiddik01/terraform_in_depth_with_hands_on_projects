# variable "ec2-instance-type" {
#   default = "t3.micro"
#   type = string
# }

# variable "ec2-ami-id" {
#   default = "ami-091138d0f0d41ff90" #ubuntu
#   type = string
# }

# variable "ec2-rbd-size" {
#     default = 15
#     type = number
# }
variable "ami_id" {
  description = "this is your ami id"
  type = string
}
variable "instance_type" {
  description = "this is your instance type"
  type = string
}
variable "instance_count" {
  description = "this is your instance count"
  type = number
}
# variable "root_block_device_type" {
#   description = "this is your root block device type"
#   type = string
# }
# variable "root_block_device_size" {
#   description = "this is your root block device size"
#   type = number
# }
variable "hash_key" {
  description = "this is your dynamodb locking key name"
  type = string
}

variable "bucket_name" {
  description = "this is your bucket name"
  type = string
}

variable "env" {
  description = "this is your env variable"
  type = string
  
}