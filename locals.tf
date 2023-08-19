locals {
  subnet=keys(var.subnets)
  subnet_cidr=values(var.subnets)
  resource_group_location=var.resource_group_location!="" ? var.resource_group_location : var.virtual_machine_location
  virtual_network_name=var.virtual_network_name=="vnet-default" ? "${var.virtual_machine_name}-${var.virtual_network_name}":var.virtual_network_name
  public_ip_name=var.public_ip_name=="pip-default" ? "${var.virtual_machine_name}-${var.public_ip_name}":var.public_ip_name
  network_interface_card_name=var.network_interface_card_name=="nic-default" ? "${var.virtual_machine_name}-${var.network_interface_card_name}":var.network_interface_card_name
  network_security_group_name=var.network_security_group_name=="nsg-default" ? "${var.virtual_machine_name}-${var.network_security_group_name}":var.network_security_group_name
  inbound_security_rule_name=var.inbound_security_rule_name=="security-rule-default" ? "${var.virtual_machine_name}-${var.inbound_security_rule_name}":var.inbound_security_rule_name
}