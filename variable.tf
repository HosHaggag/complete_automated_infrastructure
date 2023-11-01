
variable "project_id" {
    description = "The project ID to deploy to"
    type        = string
    default = "gcp-iti-401020"
  
}

variable "managment-region" {
    description = "The region to deploy for management resources"
    type        = string
    default = "us-central1"
  
}

variable "workload-region" {
    description = "The region to deploy for workload resources"
    type        = string
    default = "us-east1"
  
}

variable "region" {
    description = "The region to deploy to"
    type        = string
    default = "us-east1"
  
}

variable "zone" {
    description = "The zone to deploy to"
    type        = string
    default = "us-east1-d"
  
}

variable "tf_service_account" {
    description = "The service account to use for Terraform"
    type        = string
    default = "terraform@gcp-iti-401020.iam.gserviceaccount.com"
  
  
}