resource "google_compute_instance" "managment_instance" {
  name         = "managment-instance"
  machine_type = "e2-small"
  zone         = "${var.managment-region}-a"




  metadata = {
    startup-script = file("./startup_script.sh")
  }
  
  service_account {
    email  = var.managment_service_account
    scopes = ["cloud-platform"]

  }

  # set public ip address
  

 

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network    = var.main_vpc
    subnetwork = var.management-subnet
    access_config {
      # Include this section to give the VM an external ip address
    }
   
  }

  depends_on = [ google_artifact_registry_repository.nodejs-repo  , google_container_cluster.gke_cluster]

  

  tags = ["managment-instance"]
}
