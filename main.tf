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

resource "azurerm_virtual_network" "TFAzureMerv" {
  name                = "TFAzureMerv_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = "southafricanorth"
  resource_group_name = "RG_TFAzureMerv"
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = "RG_TFAzureMerv"
  virtual_network_name = "TFAzureMerv_vnet"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "TFAzureMerv" {
  name                = "TFAzureMerv_nic"
  location            = "southafricanorth"
  resource_group_name = "RG_TFAzureMerv"

  ip_configuration {
    name                          = "internal"
#    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "TFAzureMerv" {
  name                = "VM_TFAZureMerv"
  resource_group_name = "RG_TFAzureMerv"
  location            = "southafricanorth"
  size                = "B1s"
  admin_username      = "adminuser"
  admin_password      = "Password@123"
  network_interface_ids = "TFAzureMerv_vnet"
  
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
