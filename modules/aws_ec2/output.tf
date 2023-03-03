output "private_key" {
  value     = tls_private_key.rsa_key.private_key_pem
  sensitive = true
}

output public_ip {
value = try(aws_instance.bastion[0].public_ip, [])
}

output private_instance_id {
    value = try(aws_instance.private_ec2[0].id, [])

}