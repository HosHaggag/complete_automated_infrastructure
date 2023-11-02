
variable "managment-region" {
    type = string
    default = "us-central1"
}

variable "workload-region" {
    type = string
    default = "us-east1"
}

variable "management-subnet" {
    type = string
}

variable "workload-subnet" {
    type = string
  
}

variable "project_id" {
    type = string
}

variable "management_service_account" {
    type = string
  
}

variable "workload_service_account" {
    type = string
  
}


  


