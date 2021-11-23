# GCP Project related
variable "project" {
  type    = string
  default = ""
}

variable "region" {
  type    = string
  default = ""
}

variable "zones" {
  type    = list(any)
  default = []
}

variable "instance_name" {
  type    = string
  default = ""
}

variable "vpc_sunbnet_name" {
  type    = string
  default = ""
}

variable "vpc_subnet_range" {
  type    = string
  default = ""
}

variable "sa_roles" {
  default = {
    "iam"     = "roles/viewer"
    "storage" = "roles/storage.objectViewer"
  }
}

variable "source_ranges" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "machine_type" {
  type    = string
  default = "g1-small"
}