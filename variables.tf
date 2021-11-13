variable "location" {
  description = "Azure region"
  default     = "southafricanorth"
}

variable "vm_size" {
  description = "Type of Azure VM to provision"
  default     = "B1s"
}

variable "resource_group_name" {
  description = "Name of Azure Resource Group"
  default = "RG_TFAzureMerv"
}
