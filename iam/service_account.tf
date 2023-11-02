
resource "google_service_account" "managment_service_account" {
  account_id   = "managment-sa"
  display_name = "Managment SA "
  project      = var.project_id
}

resource "google_service_account" "workload_service_account" {
  account_id   = "workload-sa"
  display_name = "Workload SA "
  project      = var.project_id
  
}

resource "google_service_account_key" "managment_service_account_key" {
  service_account_id = google_service_account.managment_service_account.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

## save the key to a file
resource "local_sensitive_file" "managment_service_account_key" {
  content  = google_service_account_key.managment_service_account_key.private_key
  filename = "service_account_one_key.json"
}




resource "google_project_iam_member" "bind_service_acc_roles" {
    project = var.project_id
     for_each = toset([
     "roles/compute.admin",
     "roles/iam.serviceAccountUser",
     "roles/artifactregistry.admin",
      "roles/container.admin",
   ])
   role     = each.value
    member = "serviceAccount:${google_service_account.managment_service_account.email}"

}

resource "google_project_iam_member" "bind_service_acc_roles_workload" {
    project = var.project_id
     for_each = toset([
     "roles/iam.serviceAccountUser",
     "roles/artifactregistry.admin",
      "roles/container.admin",
   ])
   role     = each.value
    member = "serviceAccount:${google_service_account.workload_service_account.email}"
  
}



