variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "Mk_Rg_through_terraform"
}

variable "resource_group_location" {
  description = "The Azure region where the resource group should be created"
  type        = string
  default     = "West US"
}