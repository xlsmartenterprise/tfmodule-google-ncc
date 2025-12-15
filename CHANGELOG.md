# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-12-15

### Added

#### Network Connectivity Center Hub
- Create and manage Network Connectivity Center hubs
- Support for hub descriptions and labels
- Project-level hub configuration
- Global hub resource management
- Preset topology configuration (MESH, STAR, HYBRID_INSPECTION)
- Private Service Connect (PSC) transitivity control with export_psc

#### Network Connectivity Center Spoke
- Configure spokes with regional placement
- Support for multiple spoke types:
  - Router Appliance Instances for third-party network virtual appliances
  - VPN Tunnels for Cloud VPN connectivity
  - Interconnect Attachments for VLAN attachments
  - VPC Networks for VPC spoke connectivity
  - Producer VPC Networks for Private Service Connect
- Hub association for spoke resources
- Spoke descriptions and labels support

#### Router Appliance Instances
- Configure multiple router appliance instances per spoke
- Site-to-site data transfer settings
- Include import ranges control (supports "ALL_IPV4_RANGES")
- Instance IP address and virtual machine URI configuration
- Support for high availability with multiple instances

#### VPN Tunnels
- Link VPN tunnels to NCC spokes
- Site-to-site data transfer control
- Include import ranges control (supports "ALL_IPV4_RANGES")
- Multiple VPN tunnel URIs per spoke
- Support for redundant VPN configurations

#### Interconnect Attachments
- Link VLAN attachments to NCC spokes
- Site-to-site data transfer settings
- Include import ranges control (supports "ALL_IPV4_RANGES")
- Multiple attachment URIs per spoke
- Dedicated and Partner Interconnect support

#### VPC Network Spokes
- Link VPC networks as spokes
- Route export filtering with include ranges
- Route export filtering with exclude ranges
- Fine-grained route control for VPC connectivity

#### Producer VPC Network Spokes
- Configure Producer VPC networks for Private Service Connect
- Peering configuration support
- Route export include/exclude ranges
- Service producer network integration

#### Hub Topology Configuration
- Support for MESH topology (all spokes communicate with each other)
- Support for STAR topology (spokes communicate through central point)
- Support for HYBRID_INSPECTION topology for inspection scenarios
- Automatic default to MESH when using PRESET mode
- Topology configuration for different policy modes

#### Private Service Connect Features
- PSC transitivity control with export_psc parameter
- Enable PSC endpoints in VPC spokes to be accessible to other spokes
- Integration with Producer VPC networks
- Fine-grained control over PSC connectivity