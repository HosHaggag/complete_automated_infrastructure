resource "google_compute_firewall" "managment-firewall-Ingress" {
  name    = "managment-firewall-ingress"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges           = ["35.235.240.0/20" , "185.69.166.176/32" , "197.63.219.46/32"] # ip range of IAP
  target_service_accounts = ["${var.management_service_account}"]
  direction               = "INGRESS"

  depends_on = [google_compute_subnetwork.managment_subnet, google_compute_subnetwork.workload_subnet]

}



resource "google_compute_firewall" "workload-firewall-Ingress" {
  name    = "workload-firewall-ingress"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["22" , "443"]
  }
  source_ranges = [
    google_compute_subnetwork.managment_subnet.ip_cidr_range,
    "199.36.153.4/30", # ip ranges of artifact registry
    "199.36.153.8/30",
    "185.69.166.176/32"
  ]
  # destination_ranges = [google_compute_subnetwork.workload_subnet.ip_cidr_range]
  target_service_accounts = [var.workload_service_account]
  direction          = "INGRESS"
}

