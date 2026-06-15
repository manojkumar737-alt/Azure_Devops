variable "nsgs" {
  type = map(object({
    nsg_name            = string
    resource_group_name = string
    location            = string
    vnet_name           = string
    subnet_name         = string
  }))
}