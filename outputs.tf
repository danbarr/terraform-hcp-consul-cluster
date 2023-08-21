output "hvn_id" {
  value       = var.create_hvn ? hcp_hvn.this[0].hvn_id : local.hvn_id
  description = "ID of the HashiCorp Virtual Network (HVN)."
}

output "consul_cluster_id" {
  value       = local.cluster_id
  description = "ID of the HCP Consul cluster."
}

output "consul_private_endpoint_url" {
  value       = hcp_consul_cluster.this.consul_private_endpoint_url
  description = "Private endpoint of the HCP Consul cluster."
}

output "consul_public_endpoint_url" {
  value       = var.public_endpoint ? hcp_consul_cluster.this.consul_public_endpoint_url : null
  description = "Public endpoint of the HCP Consul cluster."
}

output "consul_version" {
  value       = hcp_consul_cluster.this.consul_version
  description = "Version of the Consul cluster."
}

output "consul_ca_file" {
  value       = hcp_consul_cluster.this.consul_ca_file
  description = "Cluster CA file encoded as a Base64 string."
}

output "consul_config_file" {
  value       = hcp_consul_cluster.this.consul_config_file
  description = "Cluster config encoded as a Base64 string."
}

output "consul_cluster_root_token" {
  value       = hcp_consul_cluster_root_token.root.secret_id
  description = "Secret ID of the root ACL token for the HCP Consul cluster."
  sensitive   = true
}
