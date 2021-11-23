output "vpc_network" {
  value       = google_compute_network.vpc.self_link
  description = "network"
}

output "vpc_network_name" {
  value       = element(split("/", google_compute_network.vpc.self_link), length(split("/", google_compute_network.vpc.self_link)) - 1)
  description = "network name"
}

output "vpc_subnetwork" {
  value       = google_compute_subnetwork.subnet.self_link
  description = "subnetwork"
}

output "instance_name" {
  value       = google_compute_instance.default.name
  description = "Instance name"
}

output "instance_zone" {
  value       = google_compute_instance.default.zone
  description = "Instance zone"
}

output "instance_internal_ip" {
  value       = google_compute_instance.default.network_interface.0.network_ip
  description = "Instance internal IP"
}

output "instance_public_ip" {
  value       = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
  description = "Instance public IP"
}

output "sa_private_key" {
  value       = google_service_account_key.sa_key.private_key
  description = "Service account key (json)"
  sensitive   = true
}

output "sa_email" {
  value       = google_service_account.service_account.email
  description = "Service account email"
}