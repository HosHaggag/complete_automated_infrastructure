


resource "google_compute_router" "managment-router" {
  name    = "managment-router"
  region  = var.managment-region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }

  depends_on = [google_compute_network.vpc_network ]
}

resource "google_compute_router_nat" "managment-nat" {
  name                               = "managment-nat"
  router                             = google_compute_router.managment-router.name
  region                             = google_compute_router.managment-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name          = google_compute_subnetwork.managment_subnet.name
    source_ip_ranges_to_nat = [google_compute_subnetwork.managment_subnet.ip_cidr_range]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

    depends_on = [google_compute_router.managment-router]
}