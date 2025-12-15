variable "hub" {
  description = "Network Connectivity Center Hub configuration"
  type = map(object({
    description     = optional(string, "")
    labels          = optional(map(string), {})
    project         = optional(string)
    preset_topology = optional(string)
    export_psc      = optional(bool, false)
  }))
  default = {}
}

variable "group" {
  description = "Network Connectivity Center Group configuration"
  type = map(object({
    hub         = string
    description = optional(string, "")
    labels      = optional(map(string), {})
    project     = optional(string)

    auto_accept = optional(object({
      auto_accept_projects = list(string)
    }))
  }))
  default = {}
}

variable "spoke" {
  description = "Network Connectivity Center Spoke configuration"
  type = map(object({
    location    = string
    hub         = string
    project     = string
    description = optional(string, "")
    group       = optional(string, "")
    labels      = optional(map(string), {})

    router_appliance_instances = optional(object({
      site_to_site_data_transfer = optional(bool, false)
      include_import_ranges      = optional(list(string), [])
      instances = optional(map(object({
        ip_address      = string
        virtual_machine = string
      })), {})
    }))

    vpn_tunnels = optional(object({
      site_to_site_data_transfer = optional(bool, false)
      uris                       = list(string)
      include_import_ranges      = optional(list(string), [])
    }))

    interconnect_attachments = optional(object({
      site_to_site_data_transfer = optional(bool, false)
      uris                       = list(string)
      include_import_ranges      = optional(list(string), [])
    }))

    vpc_network = optional(object({
      uri                   = string
      exclude_export_ranges = optional(list(string), [])
      include_export_ranges = optional(list(string), [])
    }))

    producer_vpc_network = optional(object({
      network               = string
      peering               = string
      exclude_export_ranges = optional(list(string), [])
      include_export_ranges = optional(list(string), [])
    }))
  }))
  default = {}
}
