resource "azurerm_resource_group" "mod1" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_virtual_network" "mod1" {
  name                = var.virtual_network_name
  location            = var.virtual_network_location
  resource_group_name = azurerm_resource_group.mod1.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "mod1" {
  for_each=var.subnets
  name                 = each.key
  address_prefixes     = each.value
  resource_group_name  = azurerm_resource_group.mod1.name
  virtual_network_name = azurerm_virtual_network.mod1.name
}

resource "azurerm_public_ip" "mod1" {
  name                = var.public_ip_name
  resource_group_name = azurerm_resource_group.mod1.name
  location            = azurerm_virtual_network.mod1.location
  allocation_method   = var.public_ip_allocation_method
}
resource "azurerm_network_interface" "mod1" {
  name                = var.network_interface_card_name
  location            = azurerm_virtual_network.mod1.location
  resource_group_name = azurerm_resource_group.mod1.name
  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.mod1.id
    subnet_id                     = azurerm_subnet.mod1[var.subnet_to_be_associated].id
    name                          = var.nic_ip_configuration
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

resource "azurerm_network_security_group" "mod1" {
  name                = var.network_security_group_name
  location            = azurerm_virtual_network.mod1.location
  resource_group_name = azurerm_resource_group.mod1.name

  security_rule {
    name                       = var.inbound_security_rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = var.ports
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "mod1" {
  network_security_group_id = azurerm_network_security_group.mod1.id
  subnet_id                 = azurerm_subnet.mod1[var.subnet_to_be_associated].id
}

resource "azurerm_virtual_machine" "mod1" {
  name                  = var.virtual_machine_name
  location              = azurerm_virtual_network.mod1.location
  resource_group_name   = azurerm_resource_group.mod1.name
  network_interface_ids = [azurerm_network_interface.mod1.id]
  vm_size               = var.vm_size

  delete_os_disk_on_termination    = var.virtual_machine_features.delete_os_disk
  delete_data_disks_on_termination = var.virtual_machine_features.delete_data_disk

  storage_image_reference {
    publisher = var.storage_image.publisher
    offer     = var.storage_image.offer
    sku       = var.storage_image.sku
    version   = var.storage_image.version
  }
  storage_os_disk {
    name              = var.storage_os_disk.name
    caching           = var.storage_os_disk.caching
    create_option     = var.storage_os_disk.create_option
    managed_disk_type = var.storage_os_disk.managed_disk_type
  }
  os_profile {
    computer_name  = var.admin.computer_name
    admin_username =var.admin.username
    admin_password = var.admin.password
  }
  os_profile_windows_config {
    provision_vm_agent = var.os_profile_windows_config.provision_vm_agent
    enable_automatic_upgrades = var.os_profile_windows_config.enable_automatic_upgrades
  }
}