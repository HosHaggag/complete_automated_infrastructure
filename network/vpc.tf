resource "google_compute_network" "vpc_network" {
  name                    = "main-network"
  auto_create_subnetworks = "false"
  
}