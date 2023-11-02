
module "iam" {
    source = "./iam"
    project_id = var.project_id
  
}

module "network" {
    source = "./network"
    managment-region = var.managment-region
    workload-region = var.workload-region
    management-subnet = "10.1.0.0/28"
    workload-subnet = "192.168.10.0/24"
    project_id = var.project_id
    management_service_account =  module.iam.managment_service_account_email
    workload_service_account = module.iam.workload_service_account_email
}

module "compute" {
    project_id = var.project_id
    managment_service_account =  module.iam.managment_service_account_email
    workload_service_account = module.iam.workload_service_account_email
    management-subnet = module.network.managment_subnet
    workload-subnet = module.network.workload_subnet
    managment-region = var.managment-region
    workload-region = var.workload-region
    main_vpc = module.network.main_vpc
    source = "./compute"
    depends_on = [module.network , module.iam ]
}



