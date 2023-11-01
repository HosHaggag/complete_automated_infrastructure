resource "google_artifact_registry_repository" "nodejs-repo" {
  location      = var.managment-region
  repository_id = "my-nodejs-repo"
  description   = "This is my nodejs repo for my app"
  format        = "DOCKER"
}