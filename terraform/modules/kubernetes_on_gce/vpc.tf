variable "region" {
    default = "asia-northeast1"
}

variable "vpc_subnet" {
  default = "10.0.0.0/24"
}

resource "google_compute_network" "k8s-vpc" {
  name = "k8s-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "k8s-subnet" {
  name          = "k8s-subnet"
  ip_cidr_range = var.vpc_subnet
  network       = google_compute_network.k8s-vpc.name
  description   = "test-subnet"
  region        = var.region
}

resource "google_compute_router" "nat_router" {
  name    = "nat-router"
  region  = var.region
  network = google_compute_network.k8s-vpc.id
}

resource "google_compute_address" "nat_address" {
  name    = "nat-address"
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  region                             = var.region
  router                             = google_compute_router.nat_router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}