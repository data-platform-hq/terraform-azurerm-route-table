variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists"
}

variable "resource_group" {
  type        = string
  description = "The name of the resource group in which to create the route table"
}

variable "routes" {
  type = map(object({
    address_prefix = string
    next_hop_type  = string
    next_hop_ip    = optional(string)
  }))
  description = "Map of route names to its address_prefix, next_hop_type"
  default = {}
  validation {
    condition = alltrue([
    for route in var.routes : contains(["VirtualNetworkGateway", "VnetLocal", "Internet", "VirtualAppliance", "None"], route.next_hop_type)])
    error_message = "All next_hop_type must be one of VirtualNetworkGateway,VnetLocal,Internet,VirtualAppliance or None!"
  }
  validation {
    condition = alltrue([
    for route in var.routes : ((route.next_hop_ip == null && route.next_hop_type == "VirtualAppliance") ? false : true)])
    error_message = "next_hop_ip must not be empty if next_hop_type is VirtualAppliance!"
  }
}

variable "disable_bgp_route_propagation" {
  type        = bool
  description = "Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable."
  default     = true
}

variable "tags" {
  type        = map(any)
  description = "Resource tags"
  default     = {}
}

variable "subnet_ids" {
  type        = set(any)
  description = "IDS of subnets to associate with route table"
  default     = []
}
