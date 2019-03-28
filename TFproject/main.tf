#####################################################################
##
##      Created 3/28/19 by ucdpadmin. For Cloud GKE for TFproject
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

// Google Cloud provider
provider "google" {
  version = "~> 1.5"
}

variable "unique_resource_name" {
  description = "A unique name for the resource, required by GCE."
}

variable "machine_type" {
  description = "The machine type to create."
  default = "n1-standard-1"
}

variable "boot_disk" {
  description = "The boot disk for the instance."
  default = "centos-cloud/centos-7"
}

variable "zone" {
  description = "The zone the resource should be created in."
  default = "us-central1-a"
}

// Create a new compute engine resource
resource "google_compute_instance" "default" {
  name         = "${var.unique_resource_name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  boot_disk {
    initialize_params {
      image = "${var.boot_disk}"
    }
  }
  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}

