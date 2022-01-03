resource "google_compute_vpn_tunnel" "vgw-vpc-nv-poc-nv" {
    name = "vgw-vpc-nv-poc-nv"
    network = local.vpc-name
}



locals {
  }