output "instance_ip_addr" {
  description = "rig_ip"
  value = aws_instance.rig_instance.public_ip
}

output "whitelisted" {
    value = "${var.user_cidr}:${var.rig_whitelist_port}"
}