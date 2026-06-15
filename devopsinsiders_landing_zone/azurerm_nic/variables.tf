variable "network_interfaces" {
  type = map(object({
    nic_name            = string
    resource_group_name = string
    location            = string
    vnet_name           = string
    subnet_name         = string
    tags                = map(string)
  }))
}