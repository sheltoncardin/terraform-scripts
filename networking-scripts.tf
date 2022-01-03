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

}