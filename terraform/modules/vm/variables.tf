variable "username" {
  type        = string
  description = "usuario local para la vm que hemos creado."
  default     = "programador7"
}

variable "resource_group_name" {
  type        = string
  description = "nombre del grupo de recursos al que pertenece."
}

variable "resource_group_location" {
  type        = string
  description = "ubicacion del grupo de recursos."
  default     = "eastus"
}

variable "unir_terraform_subnet" {
  type        = string
  description = "subnet del grupo de recursos."
}

variable "network_security_group" {
  type        = string
  description = "grupo donde se configurar los permisos de red."
}

variable "unir_storage_account" {
  type        = string
  description = "cuenta de servicio para el almacenamiento."
}
