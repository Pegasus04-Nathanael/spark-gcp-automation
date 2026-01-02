# ============================================
# PROVIDER
# ============================================
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# ============================================
# NETWORK
# ============================================

# VPC Custom
resource "google_compute_network" "spark_vpc" {
  name                    = "spark-vpc"
  auto_create_subnetworks = false
  description             = "VPC custom pour cluster Spark"
}

# Subnet
resource "google_compute_subnetwork" "spark_subnet" {
  name          = "spark-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.spark_vpc.id
  description   = "Subnet pour les noeuds Spark"
}

# ============================================
# FIREWALL RULES
# ============================================

# Règle Firewall - SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "spark-allow-ssh"
  network = google_compute_network.spark_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["spark-cluster"]
}

# Règle Firewall - Spark Master UI
resource "google_compute_firewall" "allow_spark_ui" {
  name    = "spark-allow-ui"
  network = google_compute_network.spark_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "7077", "4040"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["spark-master"]
}

# Règle Firewall - Communication interne
resource "google_compute_firewall" "allow_internal" {
  name    = "spark-allow-internal"
  network = google_compute_network.spark_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.subnet_cidr]
  target_tags   = ["spark-cluster"]
}

# ============================================
# COMPUTE INSTANCES
# ============================================

# Spark Master
resource "google_compute_instance" "spark_master" {
  name         = "spark-master"
  machine_type = var.machine_type_master
  zone         = var.zone

  tags = ["spark-cluster", "spark-master"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spark_subnet.id
    network_ip = "10.0.1.10"
    
    access_config {
      # IP publique éphémère
    }
  }

metadata = {
  block-project-ssh-keys = false
}

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y openjdk-11-jdk wget python3
    echo "Master initialized" > /tmp/init.log
  EOF
}

# Spark Workers
resource "google_compute_instance" "spark_workers" {
  count        = var.worker_count
  name         = "spark-worker-${count.index + 1}"
  machine_type = var.machine_type_worker
  zone         = var.zone

  tags = ["spark-cluster", "spark-worker"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spark_subnet.id
    network_ip = "10.0.1.${11 + count.index}"
    
    access_config {}
  }

metadata = {
  block-project-ssh-keys = false
}

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y openjdk-11-jdk wget python3
    echo "Worker ${count.index + 1} initialized" > /tmp/init.log
  EOF
}

# Spark Edge
resource "google_compute_instance" "spark_edge" {
  name         = "spark-edge"
  machine_type = var.machine_type_worker
  zone         = var.zone

  tags = ["spark-cluster", "spark-edge"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.spark_subnet.id
    network_ip = "10.0.1.20"
    
    access_config {}
  }

metadata = {
  block-project-ssh-keys = false
}

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y openjdk-11-jdk wget python3
    echo "Edge initialized" > /tmp/init.log
  EOF
}# GitHub Actions test - Fri Jan  2 22:24:01 UTC 2026
