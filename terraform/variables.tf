variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Ubicacion para el resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "unir"
  description = "Prefix para el nombre de resource group."
}

variable "username" {
  type        = string
  description = "usuario local para la vm que hemos creado."
  default     = "azureadmin"
}