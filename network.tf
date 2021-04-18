resource "aws_vpc" "game_now_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "GameNowVPC"
  }
}

resource "aws_subnet" "rig_subnet" {
  vpc_id     = aws_vpc.game_now_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "RigSubnet"
  }
}