locals {
  suffix = length(var.suffix) == 0 ? "" : "-${var.suffix}"
}

resource "azurerm_route_table" "this" {
  name                          = "rt-${var.project}-${var.env}-${var.location}${local.suffix}"
  location                      = var.location
  resource_group_name           = var.resource_group
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  tags                          = var.tags
}

resource "azurerm_route" "this" {
  for_each               = var.routes
  name                   = each.key
  resource_group_name    = var.resource_group
  route_table_name       = azurerm_route_table.this.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_type == "VirtualAppliance" ? each.value.next_hop_ip : null
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each       = var.subnet_ids
  subnet_id      = each.key
  route_table_id = azurerm_route_table.this.id
}
