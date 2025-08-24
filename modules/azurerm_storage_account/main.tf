resource "azurerm_storage_account" "dev_stg" {
    name=var.stg.name
    resource_group_name = var.rg_name
   location= var.location
   account_tier = "Standard"
  account_replication_type = "LRS"
  tags = var.tags
}