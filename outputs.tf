output "route_table" {
  value       = { (azurerm_route_table.this.name) = azurerm_route_table.this.id }
  description = "Map of route table name to ID"
}
