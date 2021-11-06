variable "location" {
  description = "Azure region"
  default     = "southafricanorth"
}

variable "vm_size" {
  description = "Type of Azure VM to provision"
  default     = "B1s"
}

variable "name" {
  description = "Virtual Machine Name"
  default     = "VM Provisioned by Terraform"
}

variable "resource_group_name" {
  description = "Name of Azure Resource Group"
  default = "RG Provisioned by Terraform"
}
