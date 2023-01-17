output "azurerm_route_table_this" {
  value       = { (azurerm_route_table.this.name) = azurerm_route_table.this.id }
  description = "Map of route table name to ID"
}
