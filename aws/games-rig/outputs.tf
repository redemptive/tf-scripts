output "instance_ip_addr" {
  description = "rig_ip"
  value = aws_instance.rig_instance.public_ip
}