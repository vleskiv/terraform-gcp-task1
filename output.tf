output "vpc_network_name" {
  value       = module.task.vpc_network_name
  description = "VPC network name"
}

output "instance_name" {
  value       = module.task.instance_name
  description = "Instance name"
}

output "instance_internal_ip" {
  value       = module.task.instance_internal_ip
  description = "Instance internal IP"
}

output "instance_public_ip" {
  value       = module.task.instance_public_ip
  description = "Instance public IP"
}

output "sa_private_key" {
  value       = module.task.sa_private_key
  description = "Service account key (json)"
  sensitive   = true
}

