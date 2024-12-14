# modules/network/main.tf
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.tags
}

# Public and Private Subnets - Use for-each to create subnets in each AZ
resource "aws_subnet" "public" {
  for_each = { for idx, val in var.public_subnet_cidr_blocks : idx => val }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = element(data.aws_availability_zones.available.names, each.key % length(data.aws_availability_zones.available.names))

  tags = merge(var.tags, {
    Name = "Public Subnet"
  })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = "Public Route Table"
  })
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_subnet" "private" {
  for_each = { for idx, val in var.private_subnet_cidr_blocks : idx => val }

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = element(data.aws_availability_zones.available.names, each.key % length(data.aws_availability_zones.available.names))

  tags = merge(var.tags, {
    Name = "Private Subnet"
  })
}

# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}
