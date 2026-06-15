variable "virtual_network_peerings" {
  type = map(object({
    peering_name                 = string
    resource_group_name          = string
    virtual_network_name         = string
    remote_virtual_network_name  = string
    remote_resource_group_name   = string

    allow_virtual_network_access = bool
    allow_forwarded_traffic      = bool
    allow_gateway_transit        = bool
    use_remote_gateways          = bool
  }))
}