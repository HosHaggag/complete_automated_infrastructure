
output "managment_service_account_email" {
    value = google_service_account.managment_service_account.email
}

output "workload_service_account_email" {
    value = google_service_account.workload_service_account.email
  
}