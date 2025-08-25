terraform {
  required_providers {
     azurerm = {
        source = "hashicorp/azurerm"
        version = "4.32.0"

     }
  }
  backend "azurerm" {}
    
  
}

provider "azurerm" {
    features { }
    subscription_id = "5e4fafbb-ef69-4e17-8835-68030d81f758"
  
}