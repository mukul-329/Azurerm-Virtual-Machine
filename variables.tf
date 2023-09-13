variable "resource_group_name" {
  description = "Provide New Resource Group Name in which resources will be deployed"
  type = string
  default = null
}
variable "existing_resource_group" {
  description = "Provide the name of existing resource group"
  type = string
  default = null
}
variable "resource_group_location" {
  description = "Provide Resource Group Location"
  type=string
  default = ""
}
variable "resource_group_tags" {
  description = "Resource group tagging, optional"
  type = map(string)
  default = null
}
variable "virtual_network_name" {
  description = "Mention Virtual Network"
  type = string
  default = "vnet-default"
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
  default = "pip-default"
}
variable "public_ip_allocation_method" {
  description = "Provide Static or Dynamic method allocation for public ip"
  type=string
  default="Dynamic"
}
variable "network_interface_card_name" {
  description = "Provide name of Netowrk interface card to be associated"
  type=string
  default="nic-default"
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
  description = "Name of Subnet to be associated with network card and security group, optional if you going to use default subnet "
  type=string
  default="default"   
}
variable "network_security_group_name" {
  description = "Provide Network Security Group Name"
  type=string
  default="nsg-default" 
}
# variable "inbound_security_rule_name" {
#   description = "Provide security rule name"
#   type=string
#   default="security-rule-default"
# }
variable "ports" {
  description = "Mention the ports to be applied on inblound rules"
  type=list(string)
  default = []
}

variable "virtual_machine_name" {
  description = "Provide Virtual Machine name"
  type=string
}
variable "virtual_machine_location" {
  description = "Virtual network location"
  type=string
}
variable "vm_size" {
  description = "Virtual machine size, default is free basic tier sizing"
  type=string
  default = "Standard_B1s"
}
variable "virtual_machine_admin_details" {
  description = "Provide Admin details for virtual machine like computer name, username and paasword"
  type=object({
    computer_name=string
    username = string
    password= optional(string)
  })
}
variable "storage_os_disk" {
  description = "Provide the virtual machine os disk details"
  type = object({
    name = optional(string,"default-disk")
    caching=optional(string,"ReadWrite")
    create_option=optional(string,"FromImage")
    managed_disk_type=optional(string,"Standard_LRS")
  })
  default = {}
}
variable "storage_image" {
  description = "Details for marketplace azure os image"
  type = object({
    publisher = optional(string,"microsoftwindowsserver")
    offer=optional(string,"windowsserver")
    sku=optional(string,"2016-datacenter")
    version=optional(string,"latest") 
  })
  default = {}
}

variable "virtual_machine_features" {
  description = "Additional features to lke to add in virtual machine"
  type=object({
    delete_os_disk = optional(bool,false)
    delete_data_disk= optional(bool,false)
  })
  default = {}
}
variable "os_profile_windows_config" {
  description = "Windows configuration options"
  type=object({
    provision_vm_agent= optional(bool,false)
    enable_automatic_upgrades= optional(bool,false)
  })
  default = {}
}





