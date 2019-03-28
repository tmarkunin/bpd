#####################################################################
##
##      Created 3/28/19 by ucdpadmin. For Cloud GKE for TFproject
##
#####################################################################

terraform {
  required_version = "> 0.8.0"
}

// Configure the Google Cloud provider
provider "google" {
 credentials = "${file("/home/tmarkunin/modern-ellipse-230911-32461a8aa8cc.json")}"
 project     = "modern-ellipse-230911"
 region      = "us-west1"
}


// Create a new compute engine resource


// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "flask-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}