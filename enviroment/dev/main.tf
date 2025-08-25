locals {
  common_tags={
    "ManagedBy"= "Terraform"
    "Owner" = "InfraAppTeam"
    "Environment"="dev"

  }
}
variable "RG_map" {}
module "rg"{
    source = "../../modules/azurerm_resource_group"
     RG_map=var.RG_map
  
}


module "acr" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_container_registry"
  acr_name   = "acrdevtodoapp"
  rg_name    = "dev-rg1"
  location = "centralindia"
  tags       = local.common_tags
}

module "sql_server" {
  depends_on      = [module.rg]
  source          = "../../modules/azurerm_sql_server"
  sql_server_name = "sql-dev-todoapp"
  rg_name         = "dev-rg1"
  location        = "centralindia"
  admin_username  = "devopsadmin"
  admin_password  = "P@ssw01rd@123"
  tags            = local.common_tags
}

module "sql_db" {
  depends_on  = [module.sql_server]
  source      = "../../modules/azurerm_sql_database"
  sql_db_name = "sqldb-dev-todoapp"
  server_id   = module.sql_server.server_id
  max_size_gb = "2"
  tags        = local.common_tags
}

module "aks" {
  depends_on = [module.rg]
  source     = "../../modules/azurerm_aks"
  aks_name   = "aks-dev-todoapp"
  location   = "centralindia"
  rg_name    = "rg-dev-todoapp"
  dns_prefix = "aks-dev-todoapp"
  tags       = local.common_tags
}