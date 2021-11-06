variable "region" {
  description = "Azure region"
  default     = "southafricanorth"
}

variable "instance_type" {
  description = "Type of Azure VM to provision"
  default     = "B1s"
}

variable "instance_name" {
  description = "VM name"
  default     = "Provisioned by Terraform"
}




