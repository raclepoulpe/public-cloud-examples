output "instance_ip" {
  description = "Instance public IP address"
  value       = module.instance.instance_private_ip
}
