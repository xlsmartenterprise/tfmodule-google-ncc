output "hub" {
  description = "Network Connectivity Center Hub details"
  value = {
    for k, v in google_network_connectivity_hub.main : k => {
      id              = v.id
      name            = v.name
      description     = v.description
      project         = v.project
      labels          = v.labels
      preset_topology = v.preset_topology
      export_psc      = v.export_psc
      self_link       = v.id
    }
  }
}

output "group" {
  description = "Network Connectivity Center Group details"
  value = {
    for k, v in google_network_connectivity_group.main : k => {
      id          = v.id
      name        = v.name
      hub         = v.hub
      description = v.description
      labels      = v.labels
      project     = v.project
      self_link   = v.id
    }
  }
}
output "spoke" {
  description = "Network Connectivity Center Spoke details"
  value = {
    for k, v in google_network_connectivity_spoke.main : k => {
      id          = v.id
      name        = v.name
      location    = v.location
      hub         = v.hub
      project     = v.project
      description = v.description
      group       = v.group
      labels      = v.labels
      self_link   = v.id
    }
  }
}

output "hub_ids" {
  description = "Map of hub names to IDs"
  value       = { for k, v in google_network_connectivity_hub.main : k => v.id }
}

output "spoke_ids" {
  description = "Map of spoke names to IDs"
  value       = { for k, v in google_network_connectivity_spoke.main : k => v.id }
}
