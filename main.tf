# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  subscription_id = "77355a38-f37c-40f7-97e9-31d73006cb8d"
  client_id       = "0faf94ff-7867-47db-af37-9c944cfda10f"
  client_secret   = "9c5bfc07-9535-4411-b9d7-050b5119aaf1"
  tenant_id       = "7cae8df1-0356-4a3a-9904-46e6fc32ecc2"
}

resource "azurerm_resource_group" "rg" {
  name     = "RG_TFAzure"
  location = "southafricanorth"
}
