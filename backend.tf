terraform {
    backend "gcs" {
        bucket  = "terraform-staff"
        prefix  = "terraform/state"
    }
}