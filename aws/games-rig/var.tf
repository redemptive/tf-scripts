variable "rig_vm_size" {
  default = "t2.micro"
  #default = "g4dn.xlarge"
}

variable "os_image_name" {
  type = list
  #default = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  default = ["Windows_Server-2019-English-Full-Base-*"]
}

variable "os_image_owner" {
  type = list
  #default = ["099720109477"]
  default = ["801119661308"]
}