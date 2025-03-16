# Create public IPs
resource "azurerm_public_ip" "webapp_terraform_public_ip" {
  name                = "webappPublicIP"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

# Create network interface
resource "azurerm_network_interface" "webapp_terraform_nic" {
  name                = "webappNIC"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "webapp_nic_configuration"
    subnet_id                     = var.unir_terraform_subnet
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webapp_terraform_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "webapp_unir_terraform_network" {
  network_interface_id      = azurerm_network_interface.webapp_terraform_nic.id
  network_security_group_id = var.network_security_group
}

resource "azurerm_ssh_public_key" "devops_ssh" {
  name                = "programador7"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  public_key          = file("~/.ssh/id_rsa.pub")
}


# Create virtual machine
resource "azurerm_linux_virtual_machine" "webapp_terraform_vm" {
  name                  = "unir01_webapp"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.webapp_terraform_nic.id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "webappOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  computer_name  = "webapp"
  admin_username = var.username

  admin_ssh_key {
    username   = var.username
    public_key = azurerm_ssh_public_key.devops_ssh.public_key
  }

  boot_diagnostics {
    storage_account_uri = var.unir_storage_account
  }
}