
locals {
  prefix = "my-${var.instance_name}"
}

module "task" {
  source                   = "./modules/task"
  region                   = var.region
  project                  = var.project
  vpc_name                 = "${local.prefix}-vpc"
  vpc_subnet_range         = var.vpc_subnet_range
  instance_name            = local.prefix
  private_ip_google_access = true
  sa_roles                 = var.sa_roles
  source_ranges            = var.source_ranges
  machine_type             = var.machine_type
  service_account_name     = "${local.prefix}-sa"
}