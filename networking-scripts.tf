/* provider "google" {
    project = local.project-id
    region = us-central1
} */

####################################VPC######################################

resource "google_compute_network" "vpc-nv-poc" {
  name = local.vpc-name
  auto_create_subnetworks = false

}
################################### Subnetting ################################
resource "google_compute_subnetwork" "subnet-with-secondary-ip" {
  name          = "sb-vpc-nv-poc-us-east1"
  ip_cidr_range = local.primary-ip-range-cidr
  region        = local.region
  network       = google_compute_network.vpc-nv-poc.id
  secondary_ip_range {
    range_name    = local.secondary-ip-range-1
    ip_cidr_range = local.secondary-ip-range-1-ran
  }
  secondary_ip_range {
    range_name    = local.secondary-ip-range-2
    ip_cidr_range = local.secondary-ip-range-2-ran
  }
}
################################ Firewall ############################

resource "google_compute_firewall" "fw-vpc-poc-65000-egress-deny-all" {
  name    = local.firewall65000
  network = local.vpc-name
  source_ranges=["0.0.0.0/0"]
  direction = local.directionout
  priority = 65000
  deny {
    protocol = "all"
    ports=["0-65000"]

  }
}

resource "google_compute_firewall" "fw-vpc-poc-20000-egress-allow-all-vpc-all-tcp" {
  name    = local.firewall20000
  network = local.vpc-name
  source_ranges=["172.16.0.0/18"]
  direction = local.directionout
  priority = 20000
  allow {
    protocol = "all"
    ports=["0-65000"]

  }
}

resource "google_compute_firewall" "fw-vpc-poc-19900-egrss-allow-all-on-prem-all-tcp" {
  name    = local.firewall19900
  network = local.vpc-name
  source_ranges=["172.16.0.0/16,172.23.0.0/16,172.25.0.0/16"]
  direction = local.directionout
  priority = 19900
  allow {
    protocol = "all"
    ports=["0-65000"]

  }
}

################## Locals ##################
locals {
  project-id = "sheltoncardin"
  vpc-name = "vpc-nv-poc"
  region = "us-east1"
  primary-ip-range-cidr = "172.16.0.0/20"
  secondary-ip-range-2 = "sec-ip-range-composer-service"
  secondary-ip-range-2-ran = "172.16.33.0/24"
  secondary-ip-range-1    = "sec-ip-range-composer-pods"
  secondary-ip-range-1-ran = "172.16.32.0/24"
  directionout = "EGRESS"
  directionin = "INGRESS"
  firewall65000 = "fw-vpc-poc-65000-egress-deny-all" 
  firewall20000 = "fw-vpc-poc-20000-egress-allow-all-vpc-all-tcp"
  firewall19900 = "fw-vpc-poc-19900-egrss-allow-all-on-prem-all-tcp"
}