# tf-azure-aks
Terraform Module for Azure AKS

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.k8s_cluster](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.aks-node](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_monitor_diagnostic_setting.aks-diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_subnet.k8s_agent_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.k8s_agent_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | user name to add to VMs | `string` | `"azureuser"` | no |
| <a name="input_agent_net_name"></a> [agent\_net\_name](#input\_agent\_net\_name) | Optional name of the agent vnet | `string` | `"agent-net"` | no |
| <a name="input_aks_dns_service_ip"></a> [aks\_dns\_service\_ip](#input\_aks\_dns\_service\_ip) | n/a | `string` | `"10.0.0.10"` | no |
| <a name="input_aks_docker_bridge_cidr"></a> [aks\_docker\_bridge\_cidr](#input\_aks\_docker\_bridge\_cidr) | n/a | `string` | `"172.26.0.1/16"` | no |
| <a name="input_aks_network_plugin"></a> [aks\_network\_plugin](#input\_aks\_network\_plugin) | n/a | `string` | `"azure"` | no |
| <a name="input_aks_network_policy"></a> [aks\_network\_policy](#input\_aks\_network\_policy) | n/a | `string` | `"calico"` | no |
| <a name="input_aks_pod_cidr"></a> [aks\_pod\_cidr](#input\_aks\_pod\_cidr) | n/a | `any` | `null` | no |
| <a name="input_aks_service_cidr"></a> [aks\_service\_cidr](#input\_aks\_service\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |
| <a name="input_aks_vnet_subnet_cidr"></a> [aks\_vnet\_subnet\_cidr](#input\_aks\_vnet\_subnet\_cidr) | n/a | `string` | `"10.200.0.0/24"` | no |
| <a name="input_aks_vnet_subnet_id"></a> [aks\_vnet\_subnet\_id](#input\_aks\_vnet\_subnet\_id) | n/a | `string` | `""` | no |
| <a name="input_api_server_authorized_ip_ranges"></a> [api\_server\_authorized\_ip\_ranges](#input\_api\_server\_authorized\_ip\_ranges) | List of IPs to whitelist for incoming to Kubernetes API | `list(string)` | `[]` | no |
| <a name="input_automatic_channel_upgrade"></a> [automatic\_channel\_upgrade](#input\_automatic\_channel\_upgrade) | n/a | `string` | `null` | no |
| <a name="input_azure_policy_enable"></a> [azure\_policy\_enable](#input\_azure\_policy\_enable) | Turn on Azure Policy in cluster or not | `bool` | `false` | no |
| <a name="input_client_id"></a> [client\_id](#input\_client\_id) | azure client id | `any` | `null` | no |
| <a name="input_client_secret"></a> [client\_secret](#input\_client\_secret) | azure client secret | `any` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | What the k8s cluster should be identified as | `any` | n/a | yes |
| <a name="input_create_vnet"></a> [create\_vnet](#input\_create\_vnet) | n/a | `bool` | `true` | no |
| <a name="input_default_pool"></a> [default\_pool](#input\_default\_pool) | n/a | `map` | `{}` | no |
| <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix) | n/a | `any` | n/a | yes |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | n/a | `bool` | `false` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | n/a | `string` | `"SystemAssigned"` | no |
| <a name="input_ingress_application_gateway_enable"></a> [ingress\_application\_gateway\_enable](#input\_ingress\_application\_gateway\_enable) | Ingress Application Gateway | `bool` | `false` | no |
| <a name="input_ingress_application_gateway_name"></a> [ingress\_application\_gateway\_name](#input\_ingress\_application\_gateway\_name) | n/a | `string` | `null` | no |
| <a name="input_ingress_application_subnet_cidr"></a> [ingress\_application\_subnet\_cidr](#input\_ingress\_application\_subnet\_cidr) | n/a | `string` | `null` | no |
| <a name="input_ingress_application_subnet_id"></a> [ingress\_application\_subnet\_id](#input\_ingress\_application\_subnet\_id) | n/a | `string` | `null` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | What version of k8s to request from provider | `string` | `"1.11.4"` | no |
| <a name="input_key_vault_secrets_provider"></a> [key\_vault\_secrets\_provider](#input\_key\_vault\_secrets\_provider) | n/a | <pre>map(object({<br>    secret_rotation_enabled  = string<br>    secret_rotation_interval = string<br>  }))</pre> | `null` | no |
| <a name="input_kubelet_identity"></a> [kubelet\_identity](#input\_kubelet\_identity) | Identity / RBAC goes here | <pre>object({<br>    client_id                 = string<br>    object_id                 = string<br>    user_assigned_identity_id = string<br>  })</pre> | `null` | no |
| <a name="input_load_balancer_sku"></a> [load\_balancer\_sku](#input\_load\_balancer\_sku) | Networking settings. | `string` | `"standard"` | no |
| <a name="input_log_analytics"></a> [log\_analytics](#input\_log\_analytics) | Diagnostics | <pre>map(object({<br>    enabled = bool<br>    retention = object({<br>      enabled = bool<br>      days    = number<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_managed_outbound_ip_count"></a> [managed\_outbound\_ip\_count](#input\_managed\_outbound\_ip\_count) | n/a | `number` | `1` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | Max pods to support in this cluster pr node | `number` | `30` | no |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | n/a | <pre>map(object({<br>    enabled = bool<br>    retention = object({<br>      enabled = bool<br>      days    = number<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_msd_enable"></a> [msd\_enable](#input\_msd\_enable) | Enable audit logs collected by Microsoft Defender | `bool` | `false` | no |
| <a name="input_msd_workspace_id"></a> [msd\_workspace\_id](#input\_msd\_workspace\_id) | Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to | `string` | `""` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | Node pools to use | `list` | `[]` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | n/a | `any` | `null` | no |
| <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_oms_agent_enable"></a> [oms\_agent\_enable](#input\_oms\_agent\_enable) | Enable OMS Agent profile | `bool` | `true` | no |
| <a name="input_oms_workspace_id"></a> [oms\_workspace\_id](#input\_oms\_workspace\_id) | Operations Management Suite Workspace ID | `string` | `""` | no |
| <a name="input_outbound_ip_address_ids"></a> [outbound\_ip\_address\_ids](#input\_outbound\_ip\_address\_ids) | n/a | `list(any)` | `null` | no |
| <a name="input_outbound_ip_prefix_ids"></a> [outbound\_ip\_prefix\_ids](#input\_outbound\_ip\_prefix\_ids) | n/a | `list(any)` | `null` | no |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | n/a | `string` | `"loadBalancer"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | n/a | `string` | `null` | no |
| <a name="input_rbac_admin_group_ids"></a> [rbac\_admin\_group\_ids](#input\_rbac\_admin\_group\_ids) | n/a | `list(any)` | `[]` | no |
| <a name="input_rbac_client_app_id"></a> [rbac\_client\_app\_id](#input\_rbac\_client\_app\_id) | The Client ID of an Azure Active Directory Application | `any` | `null` | no |
| <a name="input_rbac_enable"></a> [rbac\_enable](#input\_rbac\_enable) | Should RBAC be enabled. | `bool` | `true` | no |
| <a name="input_rbac_managed"></a> [rbac\_managed](#input\_rbac\_managed) | n/a | `bool` | `false` | no |
| <a name="input_rbac_server_app_id"></a> [rbac\_server\_app\_id](#input\_rbac\_server\_app\_id) | The Server ID of an Azure Active Directory Application | `any` | `null` | no |
| <a name="input_rbac_server_app_secret"></a> [rbac\_server\_app\_secret](#input\_rbac\_server\_app\_secret) | The Client Secret of an Azure Active Directory Application | `any` | `null` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the RG the environment will run inside | `string` | `"West Europe"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of RG the environment will run inside | `any` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | public key to add to admin\_user in VMs | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | # Metadata ## | `map` | `{}` | no |
| <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled) | n/a | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_identity"></a> [identity](#output\_identity) | n/a |
| <a name="output_kube_client_ca"></a> [kube\_client\_ca](#output\_kube\_client\_ca) | n/a |
| <a name="output_kube_client_certificate"></a> [kube\_client\_certificate](#output\_kube\_client\_certificate) | n/a |
| <a name="output_kube_client_key"></a> [kube\_client\_key](#output\_kube\_client\_key) | n/a |
| <a name="output_kube_cluster_ca"></a> [kube\_cluster\_ca](#output\_kube\_cluster\_ca) | n/a |
| <a name="output_kube_cluster_ca_certificate"></a> [kube\_cluster\_ca\_certificate](#output\_kube\_cluster\_ca\_certificate) | n/a |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | # Outputs ## |
| <a name="output_kube_configure"></a> [kube\_configure](#output\_kube\_configure) | n/a |
| <a name="output_kube_host"></a> [kube\_host](#output\_kube\_host) | n/a |
| <a name="output_kube_password"></a> [kube\_password](#output\_kube\_password) | n/a |
| <a name="output_kube_username"></a> [kube\_username](#output\_kube\_username) | n/a |
| <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity) | n/a |
| <a name="output_name"></a> [name](#output\_name) | Re-export the AKS name for usage |
| <a name="output_network_profile"></a> [network\_profile](#output\_network\_profile) | n/a |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | auto-generated resource group which contains the resources for this managed kubernetes cluster |
| <a name="output_node_resource_group_id"></a> [node\_resource\_group\_id](#output\_node\_resource\_group\_id) | auto-generated resource group which contains the resources for this managed kubernetes cluster |
| <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url) | n/a |
| <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn) | n/a |
<!-- END_TF_DOCS -->