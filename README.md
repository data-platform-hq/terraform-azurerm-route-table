# Azure route table Terraform module
Terraform module for route table creation with routes and subnet associations.

## Usage
This module is provisioning route table with routes and subnet associations. Below is an example that provisions route table with three routes.
```hcl
locals {
  routes = {
    "route1" = {
      address_prefix = "10.0.0.0/16"
      next_hop_type  = "VirtualAppliance"
      next_hop_ip    = "10.2.0.3"
    }
    "route2" = {
      address_prefix = "10.1.0.0/16"
      next_hop_type  = "VirtualNetworkGateway"
    }
    "route3" = {
      address_prefix = "10.2.0.0/16"
      next_hop_type  = "VnetLocal"
    }
  }
}

data "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  virtual_network_name = "example-vnet"
  resource_group_name  = "example-rg"
}

data "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  virtual_network_name = "example-vnet"
  resource_group_name  = "example-rg"
}

module "route_table" {
  source  = "data-platform-hq/route-table/azurerm"
  
  route_table_name = "example-route-table"
  location         = var.location
  resource_group   = var.resource_group
  subnet_ids       = {
    (data.azurerm_subnet.subnet1.name) = data.azurerm_subnet.subnet1.id
    (data.azurerm_subnet.subnet2.name) = data.azurerm_subnet.subnet2.id
  }
  routes = local.routes
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4.0.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route) | resource |
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bgp_route_propagation_enabled"></a> [bgp\_route\_propagation\_enabled](#input\_bgp\_route\_propagation\_enabled) | Boolean flag which controls propagation of routes learned by BGP on that route table. True means enable. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Specifies the supported Azure location where the resource exists | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group in which to create the route table | `string` | n/a | yes |
| <a name="input_route_table_name"></a> [route\_table\_name](#input\_route\_table\_name) | Route table name | `string` | n/a | yes |
| <a name="input_routes"></a> [routes](#input\_routes) | Map of route names to its address\_prefix, next\_hop\_type | <pre>map(object({<br>    address_prefix = string<br>    next_hop_type  = string<br>    next_hop_ip    = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Maps of subnet name to id, route table would associated to this subnets | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table"></a> [route\_table](#output\_route\_table) | Map of route table name to ID |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-route-table/blob/main/LICENSE)
