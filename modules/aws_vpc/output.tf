output vpc_id {
  value       = aws_vpc.vpc.id
  description = "vpc id"
}

output AZ_1 {
  value = aws_subnet.vpc_public_subnet.availability_zone
  description = "AZ zone"
}
output AZ_2 {
  value = aws_subnet.vpc_private_subnet.availability_zone
  description = "AZ zone"
}

output public_subnet {

  value = aws_subnet.vpc_public_subnet.id
  description = "public subnet"

}

output public_subnet2 {

  value = aws_subnet.vpc_p_subnet2.id
  description = "public subnet"
}

output private_subnet {

  value = aws_subnet.vpc_private_subnet.id
  description = "private subnet"
}

output security_group_ssh {
  value = [aws_security_group.ssh_sg.id]
}