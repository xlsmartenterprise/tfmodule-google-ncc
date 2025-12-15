resource "google_network_connectivity_hub" "main" {
  for_each = var.hub

  name            = each.key
  description     = each.value.description
  project         = each.value.project
  labels          = each.value.labels
  preset_topology = each.value.preset_topology
  export_psc      = each.value.export_psc
}

resource "google_network_connectivity_group" "main" {
  for_each = var.group

  name        = each.key
  hub         = each.value.hub
  description = each.value.description
  labels      = each.value.labels
  project     = each.value.project

  dynamic "auto_accept" {
    for_each = each.value.auto_accept != null ? [each.value.auto_accept] : []

    content {
      auto_accept_projects = auto_accept.value.auto_accept_projects
    }
  }

  depends_on = [google_network_connectivity_hub.main]
}

resource "google_network_connectivity_spoke" "main" {
  for_each = var.spoke

  name        = each.key
  location    = each.value.location
  description = each.value.description
  group       = each.value.group
  labels      = each.value.labels
  hub         = each.value.hub
  project     = each.value.project

  # Router Appliance Instances
  dynamic "linked_router_appliance_instances" {
    for_each = each.value.router_appliance_instances != null ? [each.value.router_appliance_instances] : []

    content {
      site_to_site_data_transfer = linked_router_appliance_instances.value.site_to_site_data_transfer
      include_import_ranges      = linked_router_appliance_instances.value.include_import_ranges

      dynamic "instances" {
        for_each = linked_router_appliance_instances.value.instances

        content {
          ip_address      = instances.value.ip_address
          virtual_machine = instances.value.virtual_machine
        }
      }
    }
  }

  # VPN Tunnels
  dynamic "linked_vpn_tunnels" {
    for_each = each.value.vpn_tunnels != null ? [each.value.vpn_tunnels] : []

    content {
      site_to_site_data_transfer = linked_vpn_tunnels.value.site_to_site_data_transfer
      uris                       = linked_vpn_tunnels.value.uris
      include_import_ranges      = linked_vpn_tunnels.value.include_import_ranges
    }
  }

  # Interconnect Attachments
  dynamic "linked_interconnect_attachments" {
    for_each = each.value.interconnect_attachments != null ? [each.value.interconnect_attachments] : []

    content {
      site_to_site_data_transfer = linked_interconnect_attachments.value.site_to_site_data_transfer
      uris                       = linked_interconnect_attachments.value.uris
      include_import_ranges      = linked_interconnect_attachments.value.include_import_ranges
    }
  }

  # VPC Network
  dynamic "linked_vpc_network" {
    for_each = each.value.vpc_network != null ? [each.value.vpc_network] : []

    content {
      uri                   = linked_vpc_network.value.uri
      exclude_export_ranges = linked_vpc_network.value.exclude_export_ranges
      include_export_ranges = linked_vpc_network.value.include_export_ranges
    }
  }

  # Producer VPC Network
  dynamic "linked_producer_vpc_network" {
    for_each = each.value.producer_vpc_network != null ? [each.value.producer_vpc_network] : []

    content {
      network               = linked_producer_vpc_network.value.network
      peering               = linked_producer_vpc_network.value.peering
      exclude_export_ranges = linked_producer_vpc_network.value.exclude_export_ranges
      include_export_ranges = linked_producer_vpc_network.value.include_export_ranges
    }
  }

  depends_on = [google_network_connectivity_hub.main]
}
