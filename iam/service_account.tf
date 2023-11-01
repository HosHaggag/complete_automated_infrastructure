
resource "google_service_account" "service_account_one" {
  account_id   = "terraform-sa-one"
  display_name = "Terraform SA One"
  project      = var.project_id
}

resource "google_service_account_key" "service_account_one_key" {
  service_account_id = google_service_account.service_account_one.name
  public_key_type    = "TYPE_X509_PEM_FILE"
}

## save the key to a file
resource "local_sensitive_file" "service_account_one_key" {
  content  = google_service_account_key.service_account_one_key.private_key
  filename = "service_account_one_key.json"
}




resource "google_project_iam_binding" "bind_service_acc_roles" {
    project = var.project_id
     for_each = toset([
     "roles/compute.admin",
     "roles/iam.serviceAccountUser",
     "roles/artifactregistry.admin",
      "roles/container.admin",
   ])
   role     = each.value
    members = ["serviceAccount:${google_service_account.service_account_one.email}"]

}



