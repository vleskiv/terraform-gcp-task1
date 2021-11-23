data "google_compute_image" "centos_image" {
  family  = "centos-8"
  project = "centos-cloud"
}

# Create VPC
resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  project                 = var.project
  auto_create_subnetworks = "false"
}

# Create network in the region
resource "google_compute_subnetwork" "subnet" {
  name                     = var.vpc_subnet_name != "" ? var.vpc_subnet_name : "${var.vpc_name}-subnet"
  ip_cidr_range            = var.vpc_subnet_range
  region                   = var.region
  network                  = google_compute_network.vpc.self_link
  private_ip_google_access = var.private_ip_google_access
}

resource "google_compute_address" "static" {
  name = "${var.instance_name}-ipv4-address"
}

resource "google_service_account" "service_account" {
  account_id   = var.service_account_name != "" ? var.service_account_name : "${var.instance_name}-service-account"
  display_name = "Instance Service account"
}

resource "google_service_account_key" "sa_key" {
  service_account_id = google_service_account.service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_project_iam_member" "sa_roles" {
  for_each = var.sa_roles
  project  = var.project
  role     = each.value
  member   = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.firewall_tags

  timeouts {
    create = "20m"
    delete = "20m"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  can_ip_forward = false

  boot_disk {
    initialize_params {
      image = data.google_compute_image.centos_image.self_link
      size  = var.disk_size_gb
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  service_account {
    email  = google_service_account.service_account.email
    scopes = var.scopes
  }
}

resource "google_compute_firewall" "fw-rule" {
  name        = "${var.instance_name}-ingress-allow"
  network     = google_compute_network.vpc.self_link
  description = "allow ssh, http(s)"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }

  target_tags   = var.firewall_tags
  source_ranges = var.source_ranges
}