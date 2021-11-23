# GCP Project related
variable "project" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone" {
  type    = string
  default = "us-central1-a"
}

variable "vpc_name" {
  type    = string
  default = "myvpc"
}

variable "vpc_subnet_name" {
  type    = string
  default = ""
}

variable "vpc_subnet_range" {
  type    = string
  default = ""
}

variable "private_ip_google_access" {
  default = false
}

variable "machine_type" {
  type    = string
  default = "g1-small"
}

variable "instance_name" {
  type    = string
  default = "myinstance"
}

variable "disk_size_gb" {
  type    = string
  default = "100"
}

variable "service_account_name" {
  type    = string
  default = ""
}

variable "scopes" {
  description = "The access to GCP scopes."
  type        = list
  default     = ["cloud-platform"]
}

variable "firewall_tags" {
  type    = list
  default = ["instance"]
}

variable "source_ranges" {
  type    = list
  default = []
}

variable "sa_roles" {
  default = {}
}