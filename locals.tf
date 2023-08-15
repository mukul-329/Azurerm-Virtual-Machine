locals {
  subnet=keys(var.subnets)
  subnet_cidr=values(var.subnets)
  virtual_network_name=var.virtual_network_name=="default" ? "${var.virtual_machine_name}-default":var.virtual_network_name
  public_ip_name=var.public_ip_name=="default" ? "${var.virtual_machine_name}-default":var.public_ip_name
  network_interface_card_name=var.network_interface_card_name=="default" ? "${var.virtual_machine_name}-default":var.network_interface_card_name
  network_security_group_name=var.network_security_group_name=="default" ? "${var.virtual_machine_name}-default":var.network_security_group_name
  inbound_security_rule_name=var.inbound_security_rule_name=="default" ? "${var.virtual_machine_name}-default":var.inbound_security_rule_name
}