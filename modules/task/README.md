# Terraform Module

It supports creating:

- A Google Virtual Private Network (VPC)
- Subnets within the VPC
- Service account
- Firewall rule
- VM instance with public ip

## Usage

```hcl
locals {
  prefix    = "my-${var.instance_name}"
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
```
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_name | The name of the network being created | `any` | n/a | yes |
| project | The ID of the project where this VPC will be created | `any` | n/a | yes |
| region | Region for all resources | string | us-central1 | yes |
| zone | Zone | string | us-central1-a | yes |
| instance_name | VM name | string | n/a | yes |
| vpc_subnet_range | Internal subnet range | string | `10.0.1.0/24` | yes |
| vpc_subnet_name | Subnet name | string | `${var.vpc_name}-subnet` | no |
| private_ip_google_access | Access to GCP services without Public IP | bool | `false` | no |
| machine_type | VM size | string | `g1-small` | no |
| disk_size_gb | OS disk size | string | `100` | no |
| service_account_name | Name of the service account | string | n/a | yes |
| scopes | Scopes | string | `["cloud-platform"]` | no |
| firewall_tags | Tags | string | `["instance"]` | no |
| source_ranges | List of public ip for ingress firewall rule | list | n/a | yes |
| sa_roles | IAM roles to be assigned to the Service account | map | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_network_name | The name of the VPC being created |
| vpc_network | The URI of the VPC being created |
| vpc_subnetwork | The self-links of subnet being created |
| instance_public_ip | Instance public IP |
| sa_private_key | Service account key (json) |


## Requirements
### Installed Software
- [Terraform](https://www.terraform.io/downloads.html) ~> 0.14
- [Terraform Provider for GCP](https://github.com/terraform-providers/terraform-provider-google) ~> 4.1.0
- [Terraform Provider for GCP Beta](https://github.com/terraform-providers/terraform-provider-google-beta) ~>
  4.1.0
- [gcloud](https://cloud.google.com/sdk/gcloud/) >243.0.0

### Configure a Service Account
In order to execute this module you must have Personal or Service Account with the following roles:

- roles/owner on the project

### Enable API's

- Compute Engine API - compute.googleapis.com
- IAM API - iam.googleapis.com

