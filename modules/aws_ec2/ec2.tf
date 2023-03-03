resource "aws_instance" "bastion" {
    count = var.create_public_ec2 ? 1 : 0
    
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    
    subnet_id = var.public_subnet
    vpc_security_group_ids = var.security_group_web
    associate_public_ip_address = var.create_public_ip
    key_name = aws_key_pair.generated_key.key_name

    user_data = var.user_data
}


resource "aws_instance" "private_ec2" {
    count = var.create_private_ec2 ? 1 : 0
    
    ami = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    
    subnet_id = var.private_subnet
    vpc_security_group_ids = var.security_group_web
    associate_public_ip_address = false
    key_name = aws_key_pair.generated_key.key_name

    user_data = var.user_data
    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    name = "web"
  }
}