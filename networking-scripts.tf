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

#fw-vpc-poc-19900-egrss-allow-all-on-prem-all-tcp
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

resource "google_compute_firewall" "fw-vpc-poc-19800-ingress-allow-on-prem-all-ssh-tcp" {
  name    = local.firewall19800
  network = local.vpc-name
  source_ranges=["172.16.0.0/16,172.23.0.0/16,172.25.0.0/16"]
  direction = local.directionin
  priority = 19800
  allow {
    protocol = "tcp"
    ports=["22"]

  }
}

resource "google_compute_firewall" "fw-vpc-poc-19700-egress-allow-all-google-api-https-tcp" {
  name    = local.firewall19700
  network = local.vpc-name
  source_ranges=["8.8.4.0/24,8.8.8.0/24,8.34.208.0/20,8.35.192.0/20,23.236.48.0/20,23.251.128.0/19,34.64.0.0/10,34.128.0.0/10,35.184.0.0/13,35.192.0.0/14,35.196.0.0/15,35.198.0.0/16,35.199.0.0/17,35.199.128.0/18,35.200.0.0/13,35.208.0.0/12,35.224.0.0/12,35.240.0.0/13,64.15.112.0/20,64.233.160.0/19,66.102.0.0/20,66.249.64.0/19,70.32.128.0/19,72.14.192.0/18,74.114.24.0/21,74.125.0.0/16,104.154.0.0/15,104.196.0.0/14,104.237.160.0/19,107.167.160.0/19,107.178.192.0/18,108.59.80.0/20,108.170.192.0/18,108.177.0.0/17,130.211.0.0/16,136.112.0.0/12,142.250.0.0/15,146.148.0.0/17,162.216.148.0/22,162.222.176.0/21,172.110.32.0/21,172.217.0.0/16,172.253.0.0/16,173.194.0.0/16,173.255.112.0/20,192.158.28.0/22,192.178.0.0/15,193.186.4.0/24,199.36.154.0/23,199.36.156.0/24,199.192.112.0/22,199.223.232.0/21,207.223.160.0/20,208.65.152.0/22,208.68.108.0/22,208.81.188.0/22,208.117.224.0/19,209.85.128.0/17,216.58.192.0/19,216.73.80.0/20,216.239.32.0/19"]
  direction = local.directionout
  priority = 19700
  allow {
    protocol = "tcp"
    ports=["443"]

  }
}
resource "google_compute_firewall" "fw-vpc-poc-allow-ssh-19600-ingress-from-iap" {
  name    = local.firewall19600
  network = local.vpc-name
  source_ranges=["35.235.240.0/20"]
  direction = local.directionin
  priority = 19600
  allow {
    protocol = "tcp"
    ports=["22"]

  }
}


resource "google_compute_firewall" "fw-vpc-poc-allow-http-https-dns-19500-egress" {
  name    = local.firewall19500
  network = local.vpc-name
  source_ranges=["0.0.0.0/0"]
  direction = local.directionout
  priority = 19500
  allow {
    protocol = "tcp"
    ports=["80,443,53"]
  }
  allow {
    protocol = "udp"
    ports=["53"]
  }
}

resource "google_compute_firewall" "fw-vpc-poc-allow-datafusion-19400-egress" {
  name    = local.firewall19400
  network = local.vpc-name
  source_ranges=["172.16.48.0/22"]
  direction = local.directionout
  priority = 19400
  allow {
    protocol = "tcp"
    ports=["22"]

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
  firewall19800 = "fw-vpc-poc-19800-ingress-allow-on-prem-all-ssh-tcp"
  firewall19700 = "fw-vpc-poc-19700-egress-allow-all-google-api-https-tcp"
  firewall19600 = "fw-vpc-poc-allow-ssh-19600-ingress-from-iap"
  firewall19500 = "fw-vpc-poc-allow-http-https-dns-19500-egress"
  firewall19400 = "fw-vpc-poc-allow-datafusion-19400-egress"
}