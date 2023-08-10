variable "resource_group_name" {
  description = "Provide Resource Group Name in which resources will be deployed"
  type = string
}
variable "resource_group_location" {
  description = "Provide Resource Group Location"
  type=string
}
variable "virtual_network_name" {
  description = "Mention Virtual Network"
  type = string
  default = "default-VNet"
}
variable "virtual_network_location" {
  description = "Virtual network location"
  type=string
}
variable "address_space"{
  description = "Provide the address space for the virtual network"
  type=list(string)
  default=["10.0.0.0/16"]
}
variable "subnets" {
  description = "No of subnets in a virtual netowrk"
  type=map(list(string))
  default = {
    default = [ "10.0.0.0/24" ]
  }
}
variable "public_ip_name" {
  description = "Provide the public ip name"
  type=string
  default = "default-ip"
}
variable "public_ip_allocation_method" {
  description = "Provide Static or Dynamic method allocation for public ip"
  type=string
  default="Dynamic"
}
variable "network_interface_card_name" {
  description = "Provide name of Netowrk interface card to be associated"
  type=string
  default="default-nic"
}
variable "nic_ip_configuration" {
  description = "Ip_configuration name for netowrk interface card"
  type=string
  default="internal"
}
variable "private_ip_address_allocation" {
  description = "Provide allocation method for private ip"
  type=string
  default="Dynamic"
}
variable "subnet_to_be_associated" {
  description = "Name of Subnet to be associated with network card and security group,optional if you going to use default subnet "
  type=string
  default="default"   
}
variable "network_security_group_name" {
  description = "Provide Network Security Group Name"
  type=string
  default="default-nsg"
}
variable "inbound_security_rule_name" {
  description = "Provide security rule name"
  type=string
  default="default-allow-rdp"
}
variable "ports" {
  description = "Mention the ports to be applied on inblound rules"
  type=list(string)
  default = [ "3389" ]
}

variable "virtual_machine_name" {
  description = "Provide Virtual Machine name"
  type=string
}
variable "vm_size" {
  description = "Virtual machine size, default is free basic tier sizing"
  type=string
  default = "Standard_B1s"
}
variable "admin" {
  description = "Provide Admin details for virtual machine like username and paasword"
  type=object({
    computer_name=string
    username = string
    password=string
  })
}
variable "storage_os_disk" {
  description = "Provide the virtual machine os disk details"
  type = object({
    name = string
    caching=string
    create_option=string
    managed_disk_type=string
  })
  default = {
    name              = "default-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}
variable "storage_image" {
  description = "Details for marketplace azure os image"
  type = object({
    publisher = string
    offer=string
    sku=string
    version=string 
  })
  default = {
    publisher = "microsoftwindowsserver"
    offer     = "windowsserver"
    sku       = "2016-datacenter"
    version   = "latest"
  }
}

variable "virtual_machine_features" {
  description = "Additional features to lke to add in virtual machine"
  type=object({
    delete_os_disk = bool
    delete_data_disk=bool 
  })
  default = {
    delete_data_disk = false
    delete_os_disk = false
  }
}
variable "os_profile_windows_config" {
  description = "Windows configuration options"
  type=object({
    provision_vm_agent = bool
    enable_automatic_upgrades=bool 
  })
  default = {
    enable_automatic_upgrades = false
    provision_vm_agent = false
  }
}





