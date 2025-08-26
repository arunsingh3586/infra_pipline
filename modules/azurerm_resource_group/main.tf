resource "azurerm_resource_group" "dev-Rg" {
    for_each = var.RG_map
    name= each.value.name
    location= each.value.location
    #tags = each.value.tags
  
}