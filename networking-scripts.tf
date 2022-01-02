provider "google" {
    project = local.project-id
    region = us-central1
}

####################################VPC######################################

resource "google_compute_network" "vpc-nv-poc" {
  name = local.vpc-name
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "subnet-with-secondary-ip" {
  name          = "sb-vpc-nv-poc-us-east1"
  ip_cidr_range = "172.16.0.0/20"
  region        = "us-east1"
  network       = google_compute_network.vpc-nv-poc.id
  secondary_ip_range {
    range_name    = "sec-ip-range-composer-pods"
    ip_cidr_range = "172.16.32.0/24"
  }
  secondary_ip_range {
    range_name    = "sec-ip-range-composer-service"
    ip_cidr_range = "172.16.33.0/24"
  }
}

locals {
  project-id = "sheltoncardin"
  vpc-name = "vpc-nv-poc"
}