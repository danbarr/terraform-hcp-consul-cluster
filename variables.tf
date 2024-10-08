variable "prefix" {
  type        = string
  description = "This prefix will be used to generate unique resource names."
}

variable "create_hvn" {
  type        = bool
  description = "Whether to create a new HVN or use an existing one."
  default     = true
}

variable "hvn_id" {
  type        = string
  description = "ID of the HVN. If `create_hvn = false`, this must be set to an existing HVN ID. If left blank and `create_hvn = true`, an ID will be generated for you."
  default     = ""

  validation {
    condition = var.hvn_id == "" ? true : (
      can(regex("^[a-zA-Z0-9-]+$", var.hvn_id)) &&
      length(var.hvn_id) >= 3 &&
      length(var.hvn_id) <= 36
    )
    error_message = "HVN ID must be 3-36 characters and can only include letters, numbers, and hyphens."
  }
}

variable "cloud_provider" {
  type        = string
  description = "Cloud provider where the HVN and Consul cluster will be located. Only used if `create_hvn = true`."
  default     = "aws"

  validation {
    condition     = contains(["", "aws", "azure"], var.cloud_provider)
    error_message = "The supported providers are 'aws' and 'azure'."
  }
}

# Supported AWS regions: https://developer.hashicorp.com/hcp/docs/hcp/supported-env/aws
# Supported Azure regions: https://developer.hashicorp.com/hcp/docs/hcp/supported-env/azure
variable "region" {
  type        = string
  description = "Region where the HVN and Consul cluster will be located. Only used if `create_hvn = true`."
  default     = "us-east-1"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the HVN."
  default     = "172.25.16.0/20"

  validation {
    condition     = can(cidrhost(var.cidr_block, 32))
    error_message = "The CIDR block must be a valid IPv4 CIDR."
  }
}

variable "consul_cluster_id" {
  type        = string
  description = "ID for the Consul cluster. If left blank, an ID will be generated for you."
  default     = ""

  validation {
    condition = var.consul_cluster_id == "" ? true : (
      can(regex("[a-zA-Z0-9-]", var.consul_cluster_id)) &&
      length(var.consul_cluster_id) >= 3 &&
      length(var.consul_cluster_id) <= 36
    )
    error_message = "Cluster ID must be 3-36 characters and can only include letters, numbers, and hyphens."
  }
}

variable "tier" {
  type        = string
  description = "Sizing tier of the Consul cluster."
  default     = "development"

  validation {
    condition     = contains(["development", "standard", "plus", "premium"], var.tier)
    error_message = "Invalid tier was specified."
  }
}

variable "min_consul_version" {
  type        = string
  description = "The minimum Consul patch version of the cluster. If not specified, it is defaulted to the version that is currently recommended by HCP."
  default     = null
}

variable "public_endpoint" {
  type        = bool
  description = "Whether the Consul cluster should have a public endpoint. If false, you will need to set up HVN peering to reach the cluster."
  default     = false
}
