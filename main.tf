terraform {
  required_version = ">= 1.2"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = ">= 0.57"
    }
  }
}

locals {
  # Supported regions for HCP Consul as of July 2023
  supported_regions = {
    "aws"   = ["us-east-1", "us-east-2", "us-west-2", "ca-central-1", "eu-central-1", "eu-west-1", "eu-west-2", "ap-northeast-1", "ap-southeast-1", "ap-southeast-2"]
    "azure" = ["westus2", "eastus", "centralus", "eastus2", "canadacentral", "westeurope", "northeurope", "francecentral", "uksouth", "southeastasia", "japaneast", "australiasoutheast"]
  }

  region_short = replace(var.region, "-", "")

  hvn_id     = var.hvn_id != "" ? var.hvn_id : "${var.prefix}-consul-hvn-${var.cloud_provider}-${local.region_short}"
  cluster_id = var.consul_cluster_id != "" ? var.consul_cluster_id : "${var.prefix}-consul-${var.cloud_provider}-${local.region_short}"
}

resource "hcp_hvn" "this" {
  count = var.create_hvn ? 1 : 0

  hvn_id         = local.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
  cidr_block     = var.cidr_block

  lifecycle {
    precondition {
      condition     = contains(local.supported_regions[var.cloud_provider], var.region)
      error_message = "${var.region} is not a supported region for HCP Consul in ${var.cloud_provider}"
    }
  }
}

moved {
  from = hcp_hvn.consul
  to   = hcp_hvn.this
}

resource "hcp_consul_cluster" "this" {
  hvn_id             = var.create_hvn ? hcp_hvn.this[0].hvn_id : local.hvn_id
  cluster_id         = local.cluster_id
  public_endpoint    = var.public_endpoint
  tier               = var.tier
  min_consul_version = var.min_consul_version
}

resource "hcp_consul_cluster_root_token" "root" {
  cluster_id = hcp_consul_cluster.this.cluster_id
}
