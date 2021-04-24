resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = merge({
    "Name" = "${var.prefix}-vpc"
  }, var.common_tags)
}

resource "aws_subnet" "rig_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.rig_subnet_cidr

  map_public_ip_on_launch = true

  tags = merge({
    Name = "${var.prefix}-rig-subnet"
  }, var.common_tags)
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "${var.prefix}-igw"
  }, var.common_tags)
}

resource "aws_route_table" "rig_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "${var.prefix}-rig-rt"
  }, var.common_tags)
}

resource "aws_route_table_association" "rig_rt_assoc" {
  subnet_id      = aws_subnet.rig_subnet.id
  route_table_id = aws_route_table.rig_rt.id
}