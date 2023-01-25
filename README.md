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

module "route_table" {
  source  = "data-platform-hq/route-table/azurerm"
  
  project        = var.project
  env            = var.env
  location       = var.location
  resource_group = var.resource_group
  subnet_ids     = toset(var.subnets)
  routes         = local.routes
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements
| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.23.0 |

## Providers

| Name                                                           | Version   |
|----------------------------------------------------------------|-----------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm)  | >= 3.23.0 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                          | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [azurerm_route_table.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table)                                       | resource |
| [azurerm_route.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route)                                                   | resource |
| [azurerm_subnet_route_table_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |


## Inputs

| Name                                                                                                                            | Description                                                                                               | Type                                                                                                                            | Default | Required |
|---------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------|---------|:--------:|
| <a name="input_project"></a> [project](#input\_project)                                                                         | Project name                                                                                              | `string`                                                                                                                        | n/a     |   yes    |
| <a name="input_env"></a> [env](#input\_env)                                                                                     | Environment name                                                                                          | `string`                                                                                                                        | n/a     |   yes    |
| <a name="input_location"></a> [location](#input\_location)                                                                      | Azure location                                                                                            | `string`                                                                                                                        | n/a     |   yes    |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)                                                  | The name of the resource group in which to create the route table                                         | `string`                                                                                                                        | n/a     |   yes    |
| <a name="input_suffix"></a> [suffix](#input\_suffix)                                                                            | Route table name suffix                                                                                   | `string`                                                                                                                        | `""`    |    no    |
| <a name="input_routes"></a> [routes](#input\_routes)                                                                            | Map of route names to its address_prefix, next_hop_type to be created in route table                      | <pre>map(object({<br> address_prefix = string <br> next_hop_type  = string <br> next_hop_ip    = optional(string) <br>}))</pre> | {}      |    no    |
| <a name="input_disable_bgp_route_propagation"></a> [disable\_bgp\_route\_propagation](#input\_disable\_bgp\_route\_propagation) | Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable. | `bool`                                                                                                                          | `true`  |    no    |
| <a name="input_tags"></a> [tags](#input\_tags)                                                                                  | A mapping of tags to assign to the resource                                                               | `map(any)`                                                                                                                      | `{}`    |    no    |
| <a name="input_subnet_ids"></a> [subnet_ids](#input\_subnet\_ids)                                                               | Set of subnets IDs to associate with route table                                                          | `list(string)`                                                                                                                  | `[]`    |    no    |

## Outputs

| Name                                                                                                        | Description                          |
|-------------------------------------------------------------------------------------------------------------|--------------------------------------|
| <a name="azurerm_route_table_this"></a> [azurerm\_route\_table\_this](#output\_azurerm\_route\_table\_this) | Map of route table name to ID.       |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-route-table/blob/main/LICENSE)
