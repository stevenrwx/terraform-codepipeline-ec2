resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"
}


resource "aws_subnet" "vpc_private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_private_cidr
  availability_zone = var.availability_zone_private

}

resource "aws_subnet" "vpc_public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_public_cidr
  availability_zone = var.availability_zone

}

resource "aws_subnet" "vpc_p_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_public_cidr_2
  availability_zone = var.availability_zone_private
}

resource "aws_route_table_association" "public_association" {
  subnet_id = aws_subnet.vpc_public_subnet.id
  route_table_id = aws_route_table.public_rt.id

}

resource "aws_route_table_association" "private_association" {
  subnet_id = aws_subnet.vpc_private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}