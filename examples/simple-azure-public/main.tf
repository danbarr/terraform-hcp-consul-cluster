terraform {
  required_version = "~> 1.2"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.57"
    }
  }
}

provider "hcp" {}

module "hcp_consul_cluster" {
  source = "../../"

  prefix          = "example"
  create_hvn      = true
  cloud_provider  = "azure"
  region          = "centralus"
  tier            = "development"
  public_endpoint = true
}

output "consul_public_endpoint_url" {
  value = module.hcp_consul_cluster.consul_public_endpoint_url
}

output "consul_version" {
  value = module.hcp_consul_cluster.consul_version
}
