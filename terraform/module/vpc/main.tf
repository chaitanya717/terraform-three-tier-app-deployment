variable "cidr_block_vpc" {}
variable "vpc_name" {}
variable "app_name" {}
variable "enviroment" {}

variable "public_subnet_cidr" {
  type = list(string)
}
variable "private_subnet_cidr" {
  type = list(string)
}

data "aws_availability_zones" "az" {
  state = "available"
}

output "public_subnets" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnets" {
  value = aws_subnet.private_subnet[*].id
}

variable "internet_gateway_name" {}
variable "nat_gateway_name" {}
variable "route_table_name_public" {}
variable "route_table_name_private" {}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "nat_gateway" {
  value = aws_nat_gateway.gw[*].id
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block_vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.az.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.az.names[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.enviroment}-${var.app_name}-${var.internet_gateway_name}"
  }
}

resource "aws_eip" "nat_ip" {
  count      = length(var.public_subnet_cidr)
  depends_on = [aws_internet_gateway.internet_gateway]
  tags = {
    Name = "${var.app_name}-${var.enviroment}-nat_ip_${count.index + 1}"
  }
}

resource "aws_nat_gateway" "gw" {
  count         = length(var.public_subnet_cidr)
  allocation_id = aws_eip.nat_ip[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_internet_gateway.internet_gateway]

  tags = {
    Name = "nat_gw_${var.app_name}-${var.enviroment}-${count.index + 1}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "${var.enviroment}-${var.app_name}-${var.route_table_name_public}"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  count  = length(var.private_subnet_cidr)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw[count.index].id
  }

  tags = {
    Name = "${var.enviroment}-${var.app_name}-${var.route_table_name_private}"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
