variables {
  prefix          = "example"
  create_hvn      = true
  cloud_provider  = "aws"
  region          = "us-east-1"
  tier            = "development"
  public_endpoint = true
}

provider "hcp" {}

run "validate_inputs" {
  command = plan

  variables {
    cloud_provider = "amazon"
    tier           = "ultra"
    create_hvn     = false
    hvn_id         = "my_hvn"
  }

  expect_failures = [var.cloud_provider, var.tier, var.hvn_id]
}

run "validate_region_aws" {
  command = plan

  variables {
    cloud_provider = "aws"
    region         = "us-west-1" # Not a supported region for AWS
  }

  expect_failures = [hcp_hvn.this]
}

run "unit_test_aws" {
  command = plan

  assert {
    condition     = hcp_consul_cluster.this.cluster_id == "example-consul-aws-useast1"
    error_message = "The cluster ID did not match expected."
  }

  assert {
    condition     = hcp_consul_cluster.this.hvn_id == "example-consul-hvn-aws-useast1"
    error_message = "The HVN ID used for the cluster did not match expected."
  }
}

run "unit_test_azure" {
  command = plan

  variables {
    cloud_provider = "azure"
    region         = "centralus"
  }

  assert {
    condition     = hcp_consul_cluster.this.cluster_id == "example-consul-azure-centralus"
    error_message = "The cluster ID did not match expected."
  }

  assert {
    condition     = hcp_consul_cluster.this.hvn_id == "example-consul-hvn-azure-centralus"
    error_message = "The HVN ID used for the cluster did not match expected."
  }
}
