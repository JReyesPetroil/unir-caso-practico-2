variable "resource_group_name" {
  type        = string
  description = "nombre del grupo de recursos al que pertenece."
}

variable "resource_group_location" {
  type        = string
  description = "ubicacion del grupo de recursos."
  default     = "eastus"
}
