# Create a GCP storage bucket
resource "google_storage_bucket" "my_bucket" {
  name     = "80760173"
  location = var.region

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}

# Apply a policy to the bucket allowing only read access
resource "google_storage_bucket_iam_member" "bucket_policy" {
  bucket = google_storage_bucket.my_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Create a VPC network
resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc"
  auto_create_subnetworks = false
}

# Create an internet gateway
resource "google_compute_global_address" "my_gateway_ip" {
  name      = "my-gateway-ip"
  ip_version = "IPV4"
}

# Create subnets
resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet1"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.my_vpc.name
  region        = var.region
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet2"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.my_vpc.name
  region        = var.region
}

resource "google_compute_subnetwork" "subnet3" {
  name          = "subnet3"
  ip_cidr_range = "10.0.3.0/24"
  network       = google_compute_network.my_vpc.name
  region        = var.region
}

# Create security groups for each subnet
resource "google_compute_firewall" "security_group1" {
  name    = "security-group1"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "security_group2" {
  name    = "security-group2"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "security_group3" {
  name    = "security-group3"
  network = google_compute_network.my_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Create separate default routes for each subnet
resource "google_compute_route" "route1" {
  name                  = "route1"
  network               = google_compute_network.my_vpc.name
  dest_range            = "0.0.0.0/0"
  next_hop_gateway      = google_compute_global_address.my_gateway_ip.self_link
}

resource "google_compute_route" "route2" {
  name                  = "route2"
  network               = google_compute_network.my_vpc.name
  dest_range            = "0.0.0.0/0"
  next_hop_gateway      = google_compute_global_address.my_gateway_ip.self_link
}

resource "google_compute_route" "route3" {
  name                  = "route3"
  network               = google_compute_network.my_vpc.name
  dest_range            = "0.0.0.0/0"
  next_hop_gateway      = google_compute_global_address.my_gateway_ip.self_link
}

# Create web server instances
resource "google_compute_instance" "web_server1" {
  name         = "web-server1"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network   = google_compute_network.my_vpc.name
    subnetwork = google_compute_subnetwork.subnet1.name
  }
}

resource "google_compute_instance" "web_server2" {
  name         = "web-server2"
  machine_type = "n1-standard-1"
  zone         = "${var.region}-b"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network   = google_compute_network.my_vpc.name
    subnetwork = google_compute_subnetwork.subnet2.name
  }
}

# Create database server instance
resource "google_compute_instance" "db_server" {
  name         = "db-server"
  machine_type = "n1-standard-2"
  zone         = "${var.region}-c"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network   = google_compute_network.my_vpc.name
    subnetwork = google_compute_subnetwork.subnet3.name
  }
}
