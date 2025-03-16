resource "azurerm_container_registry" "unir_acr" {
  name                = "unirJReyesACR"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = "Basic"
}

# resource "azurerm_kubernetes_cluster" "unir_aks" {
#   name                = "unir-aks1"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   dns_prefix          = "uniraks1"

#   default_node_pool {
#     name       = "default"
#     node_count = 1
#     vm_size    = "Standard_D2_v2"
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = {
#     Environment = "Production"
#   }
# }

# resource "azurerm_role_assignment" "unir_acr_role" {
#   principal_id                     = azurerm_kubernetes_cluster.unir_aks.kubelet_identity[0].object_id
#   role_definition_name             = "AcrPull"
#   scope                            = azurerm_container_registry.unir_acr.id
#   skip_service_principal_aad_check = true
# }
