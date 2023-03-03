variable "availability_zone" {
  default = "eu-west-2"
  description = "AZ zone"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "public_subnet" {
description = "public subnet"
default = false
}

variable "private_subnet" {
description = "private subnet"
default = false
}
variable "security_group_web" {
description = "ALLOW access from internet"
}
variable "create_public_ip" {
description = "bool to create public ip"
}

variable "key_name" {
  description = "name of key"
}

variable "create_public_ec2" {
description = "bool to create public EC2"
default = false
}
variable "create_private_ec2" {
description = "bool to create private EC2"
default = false
}
variable "user_data" {
description = "bool to create user_data script"
default = false
}