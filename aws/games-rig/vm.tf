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

  tags = merge({
    Name = "${var.prefix}-rig-ni"
  }, var.common_tags)
}

resource "aws_security_group" "rig_sg" {
  name        = "${var.prefix}-sg"
  description = "Allow RDP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "RDP"
    from_port        = var.rig_whitelist_port
    to_port          = var.rig_whitelist_port
    protocol         = "tcp"
    cidr_blocks      = [var.user_cidr]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.prefix}-rig-sg"
  }, var.common_tags)
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

  tags = merge({
    Name = "${var.prefix}-rig"
  }, var.common_tags)

  depends_on = [aws_internet_gateway.igw]
}