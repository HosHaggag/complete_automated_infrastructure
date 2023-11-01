## create GKE cluster with 3 nodes separated by zones in the same region
# and stateful workload mongodb installed on each node with replica set configuration, 1 master and 2 slaves 




resource "google_container_cluster" "gke_cluster" {
  name               = "workload-cluster"
  location           = var.workload-region
  ## private cluster

  ## deletion protection disabled
  deletion_protection = false
  

private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes   = true 
    master_ipv4_cidr_block = "192.168.9.0/28"

     master_global_access_config {
    enabled = true
  }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "192.167.0.0/21"
    services_ipv4_cidr_block = "192.166.0.0/21"
  }

  
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.1.0.0/28"
      display_name = "net1"
    }

  }
  

 

  initial_node_count = 1
  remove_default_node_pool = true

  node_locations = [
    "${var.workload-region}-d",
    "${var.workload-region}-b",
    "${var.workload-region}-c", ]


  depends_on = [ google_compute_instance.managment_instance ]
  network = var.main_vpc
  subnetwork = var.workload-subnet
}


resource "google_container_node_pool" "primary_node_pool" {
  name       = "primary-node-pool"
  location   = var.workload-region
  cluster    = google_container_cluster.gke_cluster.name
  node_count = 1
  node_config {
    machine_type = "e2-small"
    disk_size_gb = 20
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  depends_on = [ google_container_cluster.gke_cluster ]
}



## create mongodb stateful workload on each node

