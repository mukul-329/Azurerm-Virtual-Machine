output "subnets" {
  value = azurerm_subnet.mod1
}
output "virtual_network" {
  value = azurerm_virtual_network.mod1
}
output "resource_group" {
  value=azurerm_resource_group.mod1
}
output "public_ip" {
  value=azurerm_public_ip.mod1
}
output "network_security_group" {
  value=azurerm_network_security_group.mod1
}
output "network_interface" {
  value = azurerm_network_interface.mod1
}
output "virtual_machine" {
  value=azurerm_virtual_machine.mod1
}
