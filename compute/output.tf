

output "managment_instance_ip" {
    value = google_compute_instance.managment_instance.network_interface[0].network_ip
  
}

