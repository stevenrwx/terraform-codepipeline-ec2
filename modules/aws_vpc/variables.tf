variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
  description = "Private VPC address"
}

variable "subnet_private_cidr" {
  default = "10.0.1.0/24"
  description = "VPC private subnet"
}

variable "subnet_public_cidr" {
  default = "10.10.0.0/24"
  description = "VPC private subnet"
}
variable "subnet_public_cidr_2" {
  default = "10.20.0.0/24"
  description = "VPC private subnet"
}

variable "availability_zone" {
  default = "eu-west-2a"
  description = "AZ zone"
}

variable "availability_zone_private" {
  default = "eu-west-2b"
  description = "AZ zone"
}
