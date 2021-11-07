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

resource "azurerm_resource_group" "TFAzureMerv" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    "Owner" = "Mervyn"
    "Purpose" = "Test"
    "BU" = "ICS"
  }
}

resource "azurerm_virtual_network" "TFAzureMerv" {
  name                = "TFAzureMervVNET"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "TFAzureMerv" {
  name                 = "TFAzureMervSUB"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.TFAzureMerv.name
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_network_interface" "TFAzureMerv" {
  name                = "TFAzureMervNIC"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = azurerm_subnet.TFAzureMerv.name
    subnet_id                     = azurerm_subnet.TFAzureMerv.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "TFAzureMerv" {
  computer_name       = "TFAZureMerv-VM"
  name                = "TFAZureMervVM"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = "TFAzureMervAdmin"
  admin_password      = "Password@123"
  network_interface_ids = [azurerm_network_interface.TFAzureMerv.id]
  
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
