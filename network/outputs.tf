output main_vpc {
value = google_compute_network.vpc_network.self_link
}

output managment_subnet {
    value = google_compute_subnetwork.managment_subnet.self_link
}

output workload_subnet {
    value = google_compute_subnetwork.workload_subnet.self_link
}


