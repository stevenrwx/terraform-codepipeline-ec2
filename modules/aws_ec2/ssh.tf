resource "tls_private_key" "rsa_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_key.public_key_openssh

  provisioner "local-exec" {
    command = <<EOT
        echo '${tls_private_key.rsa_key.private_key_pem}' > ./'${var.key_name}'.pem
        chmod 600 ./'${var.key_name}'.pem
    EOT
  }

  provisioner "local-exec" {
    command = "sudo rm -f ${path.cwd}/${self.key_name}.pem"
    when = destroy
  }
}
