resource "aws_vpc" "terraform_vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

}

locals {
  additional_tags = {
    "kubernetes.io/cluster/${var.ekscluster-name}" = "owned"
    "kubernetes.io/role/elb"                       = "1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform_vpc.id

}

resource "aws_subnet" "public_1" {
  cidr_block              = var.subnet-cidrblock-pub1
  vpc_id                  = aws_vpc.terraform_vpc.id
  map_public_ip_on_launch = var.subnet-map_public_ip_on_launch_public
  availability_zone       = var.subnet-az-2a

  tags = local.additional_tags
}
resource "aws_subnet" "private_1" {
  cidr_block              = var.subnet-cidrblock-pri1
  vpc_id                  = aws_vpc.terraform_vpc.id
  map_public_ip_on_launch = var.subnet-map_public_ip_on_launch_private
  availability_zone       = var.subnet-az-2a

  tags = local.additional_tags
}

resource "aws_subnet" "public_2" {
  cidr_block              = var.subnet-cidrblock-pub2
  vpc_id                  = aws_vpc.terraform_vpc.id
  map_public_ip_on_launch = var.subnet-map_public_ip_on_launch_public
  availability_zone       = var.subnet-az-2b

  tags = local.additional_tags
}

resource "aws_subnet" "private_2" {
  cidr_block              = var.subnet-cidrblock-pri2
  vpc_id                  = aws_vpc.terraform_vpc.id
  map_public_ip_on_launch = var.subnet-map_public_ip_on_launch_private
  availability_zone       = var.subnet-az-2b

  tags = local.additional_tags
}

resource "aws_subnet" "public_3" {
  cidr_block              = var.subnet-cidrblock-pub3
  vpc_id                  = aws_vpc.terraform_vpc.id
  map_public_ip_on_launch = var.subnet-map_public_ip_on_launch_public
  availability_zone       = var.subnet-az-2c
  tags                    = local.additional_tags
}

resource "aws_subnet" "private_3" {
  cidr_block              = var.subnet-cidrblock-pri3
  vpc_id                  = aws_vpc.terraform_vpc.id
  map_public_ip_on_launch = var.subnet-map_public_ip_on_launch_private
  availability_zone       = var.subnet-az-2c
  tags                    = local.additional_tags
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.ngw_eip.id
  subnet_id     = aws_subnet.public_1.id

  depends_on = [aws_internet_gateway.gw]

}

resource "aws_eip" "ngw_eip" {

}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = var.routetable-cidr
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public_3.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block     = var.routetable-cidr
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_route.id
}

resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private_3.id
  route_table_id = aws_route_table.private_route.id
}