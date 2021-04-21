data "aws_ami" "rig_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = var.os_image_name
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = var.os_image_owner
}

resource "aws_network_interface" "rig_ni" {
  subnet_id   = aws_subnet.rig_subnet.id
  security_groups = [aws_security_group.rig_sg.id]

  tags = {
    Name = "interface_1"
  }
}

resource "aws_security_group" "rig_sg" {
  name        = "rig_sg"
  description = "Allow RDP inbound traffic"
  vpc_id      = aws_vpc.game_now_vpc.id

  ingress {
    description      = "RDP"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rig_sg"
  }
}

resource "aws_instance" "rig_instance" {
  ami           = data.aws_ami.rig_ami.id
  instance_type = var.rig_vm_size

  key_name = "rig_test_key"

  user_data = "${file("script/provision_rig.ps1")}"

  network_interface {
    network_interface_id = aws_network_interface.rig_ni.id
    device_index         = 0
  }

  tags = {
    Name = "Rig1"
  }

  depends_on = [aws_internet_gateway.rig_igw]
}