resource "google_compute_instance" "managment_instance" {
  name         = "managment-instance"
  machine_type = "e2-small"
  zone         = "${var.managment-region}-a"




  metadata = {
    startup-script = file("./startup.sh")
  }
  
  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]

  }

 

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network    = var.main_vpc
    subnetwork = var.management-subnet
   
  }

  depends_on = [ google_artifact_registry_repository.nodejs-repo ]

  

  tags = ["managment-instance"]
}
