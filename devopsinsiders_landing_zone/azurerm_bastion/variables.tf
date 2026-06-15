variable "bastion_hosts" {
  type = map(object({
    bastion_name          = string
    resource_group_name   = string
    location              = string
    ip_configuration_name = string
    subnet_id             = string
    public_ip_address_id  = string
  }))
}