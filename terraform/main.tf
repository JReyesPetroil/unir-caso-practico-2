# resource "random_pet" "rg_name" {
#   prefix = var.resource_group_name_prefix
# }

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "unir-resource-group"
}

# Create virtual network
resource "azurerm_virtual_network" "unir_terraform_network" {
  name                = "unirVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "unir_terraform_subnet" {
  name                 = "unirSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.unir_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "unir_terraform_nsg" {
  name                = "UnirNetworkSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "unir_storage_account" {
  name                     = "unirstorageaccount"
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

module "vm" {
  source = "./modules/vm"
  username = "programador7"
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  unir_terraform_subnet = azurerm_subnet.unir_terraform_subnet.id
  network_security_group = azurerm_network_security_group.unir_terraform_nsg.id
  unir_storage_account = azurerm_storage_account.unir_storage_account.primary_blob_endpoint
}

module "aks" {
  source = "./modules/cluster"
  resource_group_name = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location  
}
