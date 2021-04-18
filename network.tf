resource "aws_vpc" "game_now_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "GameNowVPC"
  }
}

resource "aws_subnet" "rig_subnet" {
  vpc_id     = aws_vpc.game_now_vpc.id
  cidr_block = "10.0.0.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name = "RigSubnet"
  }
}

resource "aws_internet_gateway" "rig_igw" {
  vpc_id = aws_vpc.game_now_vpc.id

  tags = {
    Name = "RigIGW"
  }
}

resource "aws_route_table" "rig_rt" {
  vpc_id = aws_vpc.game_now_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rig_igw.id
  }

  tags = {
    Name = "RigRT"
  }
}

resource "aws_route_table_association" "rig_rt_assoc" {
  subnet_id      = aws_subnet.rig_subnet.id
  route_table_id = aws_route_table.rig_rt.id
}