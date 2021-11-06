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

}

resource "azurerm_resource_group" "rg" {
  name     = "RG_TFAzureMerv"
  location = "southafricanorth"
  tags = {
    "Owner" = "Mervyn"
    "Purpose" = "Test"
    "BU" = "ICS"
  }
}

resource "azurerm_windows_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = "RG_TFAzureMerv"
  location            = "southafricanorth"
  size                = "B1s"
  admin_username      = "adminuser"
  admin_password      = "Password@123"
  network_interface_ids = "ipconfig1"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
