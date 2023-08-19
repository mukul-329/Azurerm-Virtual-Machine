output "subnets" {
  value = azurerm_subnet.mod1
  description="Attributes reference of all the subnets created in a virtual network"
}
output "virtual_network" {
  value = azurerm_virtual_network.mod1
  description="Attributes reference for virtual network"
}
output "resource_group" {
  value=local.resource_group
  description="Attributes reference for the resource group"
}
output "public_ip" {
  value=azurerm_public_ip.mod1
  description="Attributes reference for the public ip created for virtual machine"
}
output "network_security_group" {
  value=azurerm_network_security_group.mod1
  description="Attributes reference for the network security group and security rules"
}
output "network_interface" {
  value = azurerm_network_interface.mod1
  description="Attributes reference for network interface card"
}
output "virtual_machine" {
  value=azurerm_virtual_machine.mod1
  description="Attributes reference for virtual machine"
}
