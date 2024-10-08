# HCP Consul Cluster Terraform Module

Terraform module which provisions a simple HCP Consul cluster for demonstration purposes. Only a subset of the available configuration options are exposed.

By default a HashiCorp Virtual Network is also created, unless `create_hvn = false` and the `hvn_id` of an existing HVN is supplied.

Prerequisites:

- An HCP organization
- HCP "Contributor" credentials set as environment variables `HCP_CLIENT_ID` and `HCP_CLIENT_SECRET` (see the HCP provider [authentication guide](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/guides/auth)). Optionally specify `HCP_PROJECT_ID`. If not included, the oldest project in the organization will be used.
  - If using a project-level service principal, `HCP_PROJECT_ID` is required

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | >= 0.57 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | >= 0.57 |

## Resources

| Name | Type |
|------|------|
| [hcp_consul_cluster.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/consul_cluster) | resource |
| [hcp_consul_cluster_root_token.root](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/consul_cluster_root_token) | resource |
| [hcp_hvn.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_prefix"></a> [prefix](#input\_prefix) | This prefix will be used to generate unique resource names. | `string` | n/a | yes |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | CIDR block for the HVN. | `string` | `"172.25.16.0/20"` | no |
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | Cloud provider where the HVN and Consul cluster will be located. Only used if `create_hvn = true`. | `string` | `"aws"` | no |
| <a name="input_consul_cluster_id"></a> [consul\_cluster\_id](#input\_consul\_cluster\_id) | ID for the Consul cluster. If left blank, an ID will be generated for you. | `string` | `""` | no |
| <a name="input_create_hvn"></a> [create\_hvn](#input\_create\_hvn) | Whether to create a new HVN or use an existing one. | `bool` | `true` | no |
| <a name="input_hvn_id"></a> [hvn\_id](#input\_hvn\_id) | ID of the HVN. If `create_hvn = false`, this must be set to an existing HVN ID. If left blank and `create_hvn = true`, an ID will be generated for you. | `string` | `""` | no |
| <a name="input_min_consul_version"></a> [min\_consul\_version](#input\_min\_consul\_version) | The minimum Consul patch version of the cluster. If not specified, it is defaulted to the version that is currently recommended by HCP. | `string` | `null` | no |
| <a name="input_public_endpoint"></a> [public\_endpoint](#input\_public\_endpoint) | Whether the Consul cluster should have a public endpoint. If false, you will need to set up HVN peering to reach the cluster. | `bool` | `false` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the HVN and Consul cluster will be located. Only used if `create_hvn = true`. | `string` | `"us-east-1"` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | Sizing tier of the Consul cluster. | `string` | `"development"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_consul_ca_file"></a> [consul\_ca\_file](#output\_consul\_ca\_file) | Cluster CA file encoded as a Base64 string. |
| <a name="output_consul_cluster_id"></a> [consul\_cluster\_id](#output\_consul\_cluster\_id) | ID of the HCP Consul cluster. |
| <a name="output_consul_cluster_root_token"></a> [consul\_cluster\_root\_token](#output\_consul\_cluster\_root\_token) | Secret ID of the root ACL token for the HCP Consul cluster. |
| <a name="output_consul_config_file"></a> [consul\_config\_file](#output\_consul\_config\_file) | Cluster config encoded as a Base64 string. |
| <a name="output_consul_private_endpoint_url"></a> [consul\_private\_endpoint\_url](#output\_consul\_private\_endpoint\_url) | Private endpoint of the HCP Consul cluster. |
| <a name="output_consul_public_endpoint_url"></a> [consul\_public\_endpoint\_url](#output\_consul\_public\_endpoint\_url) | Public endpoint of the HCP Consul cluster. |
| <a name="output_consul_version"></a> [consul\_version](#output\_consul\_version) | Version of the Consul cluster. |
| <a name="output_hvn_id"></a> [hvn\_id](#output\_hvn\_id) | ID of the HashiCorp Virtual Network (HVN). |
<!-- END_TF_DOCS -->