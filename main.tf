data "azurerm_resource_group" "mod1" {
  count= var.existing_resource_group !=null ? 1 : 0
  name = var.existing_resource_group
}

resource "azurerm_resource_group" "mod1" {
  count = var.resource_group_name !=null ? 1 : 0
  name     = var.resource_group_name
  location = local.resource_group_location
  tags = var.resource_group_tags
}

locals {
  # resource_group= var.resource_group_name != null ? azurerm_resource_group.mod1[0] : data.azurerm_resource_group.mod1[0]
  resource_group=try(azurerm_resource_group.mod1[0],data.azurerm_resource_group.mod1[0])
}

resource "azurerm_virtual_network" "mod1" {
  name                = local.virtual_network_name
  location            = var.virtual_machine_location
  resource_group_name = local.resource_group.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "mod1" {
  count=length(var.subnets)
  name                 = local.subnet[count.index]
  address_prefixes     = local.subnet_cidr[count.index]
  resource_group_name  = local.resource_group.name
  virtual_network_name = azurerm_virtual_network.mod1.name
}

resource "azurerm_public_ip" "mod1" {
  name                = local.public_ip_name
  resource_group_name = local.resource_group.name
  location            = azurerm_virtual_network.mod1.location
  allocation_method   = var.public_ip_allocation_method
}
resource "azurerm_network_interface" "mod1" {
  name                = local.network_interface_card_name
  location            = azurerm_virtual_network.mod1.location
  resource_group_name = local.resource_group.name
  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.mod1.id
    subnet_id                     = azurerm_subnet.mod1[index(local.subnet,var.subnet_to_be_associated)].id
    name                          = var.nic_ip_configuration
    private_ip_address_allocation = var.private_ip_address_allocation
  }
}

resource "azurerm_network_security_group" "mod1" {
  name                = local.network_security_group_name
  location            = azurerm_virtual_network.mod1.location
  resource_group_name = local.resource_group.name

  security_rule {
    name                       = local.inbound_security_rule_name
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
  subnet_id                 = azurerm_subnet.mod1[index(local.subnet,var.subnet_to_be_associated)].id
}

resource "azurerm_virtual_machine" "mod1" {
  name                  = var.virtual_machine_name
  location              = azurerm_virtual_network.mod1.location
  resource_group_name   = local.resource_group.name
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
    computer_name  = var.vm_admin.computer_name
    admin_username =var.vm_admin.username
    admin_password = var.vm_admin.password
  }
  os_profile_windows_config {
    provision_vm_agent = var.os_profile_windows_config.provision_vm_agent
    enable_automatic_upgrades = var.os_profile_windows_config.enable_automatic_upgrades
  }
}