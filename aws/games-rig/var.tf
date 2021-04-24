variable "region" {
  default = "eu-west-2"
}

variable "common_tags" {
  default = { "ManagedBy" = "Terraform"}
}

# Networking

variable "prefix" {
  default = "gamenow"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "rig_subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "user_cidr" {
  default = "0.0.0.0/0"
}

variable "rig_whitelist_port" {
  default = 22
}

# Rig VM Information

variable "rig_vm_size" {
  default = "t2.micro"
  #default = "g4dn.xlarge"
}

variable "os_image_name" {
  type = list
  default = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  #default = ["Windows_Server-2019-English-Full-Base-*"]
}

variable "os_image_owner" {
  type = list
  default = ["099720109477"]
  #default = ["801119661308"]
}