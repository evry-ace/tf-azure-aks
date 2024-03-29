## Metadata ##
variable "tags" {
  default = {}
}

## Environment variables ##
variable "resource_group_name" {
  description = "Name of RG the environment will run inside"
}

variable "resource_group_location" {
  description = "Location of the RG the environment will run inside"
  default     = "West Europe"
}

## AKS variables ##
variable "agent_net_name" {
  type        = string
  description = "Optional name of the agent vnet"
  default     = "agent-net"
}

variable "k8s_version" {
  description = "What version of k8s to request from provider"
  default     = "1.11.4"
}

variable "cluster_name" {
  description = "What the k8s cluster should be identified as"
}

variable "dns_prefix" {
  description = ""
  #  default     = "${var.cluster-name}-${var.environment}"
}

variable "max_pods" {
  default     = 30
  description = "Max pods to support in this cluster pr node"
}

variable "default_pool" {
  default = {}
}

variable "node_pools" {
  description = "Node pools to use"
  default     = []
}

variable "node_resource_group" {
  default = null
}

variable "admin_username" {
  description = "user name to add to VMs"
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "public key to add to admin_user in VMs"
}

variable "client_id" {
  default     = null
  description = "azure client id"
}

variable "client_secret" {
  default     = null
  description = "azure client secret"
}

variable "identity_type" {
  default = "SystemAssigned"
}

variable "identity_ids" {
  type    = list(string)
  default = []
}


# Identity / RBAC goes here
variable "kubelet_identity" {
  type = object({
    client_id                 = string
    object_id                 = string
    user_assigned_identity_id = string
  })

  default = null
}

variable "oidc_issuer_enabled" {
  type    = bool
  default = false
}

variable "workload_identity_enabled" {
  type    = bool
  default = false
}

## RBAC variables ##
variable "rbac_enable" {
  description = "Should RBAC be enabled."
  default     = true
}

variable "rbac_managed" {
  type    = bool
  default = false
}

variable "rbac_client_app_id" {
  default     = null
  description = "The Client ID of an Azure Active Directory Application"
}

variable "rbac_server_app_id" {
  default     = null
  description = "The Server ID of an Azure Active Directory Application"
}

variable "rbac_server_app_secret" {
  default     = null
  description = "The Client Secret of an Azure Active Directory Application"
}

variable "rbac_admin_group_ids" {
  default = []
  type    = list(any)
}

#variable "rbac_tenant_id" {
#	description = "The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used"
#}

# Networking settings.
variable "load_balancer_sku" {
  default = "standard"
  type    = string
}

variable "managed_outbound_ip_count" {
  default = 1
  type    = number
}

variable "outbound_ip_address_ids" {
  default = null
  type    = list(any)
}

variable "outbound_ip_prefix_ids" {
  default = null
  type    = list(any)
}

variable "outbound_type" {
  default = "loadBalancer"
  type    = string
}

variable "aks_network_plugin" {
  default = "azure"
}

variable "aks_network_policy" {
  default = "calico"
}

variable "aks_pod_cidr" {
  default = null
}

variable "aks_service_cidr" {
  default = "10.0.0.0/16"
}

variable "aks_docker_bridge_cidr" {
  default = "172.26.0.1/16"
}

variable "aks_dns_service_ip" {
  default = "10.0.0.10"
}

variable "aks_vnet_subnet_id" {
  default = ""
}

variable "aks_vnet_subnet_cidr" {
  default = "10.200.0.0/24"
}

variable "create_vnet" {
  default = true
}

variable "oms_workspace_id" {
  description = "Operations Management Suite Workspace ID"
  default     = ""
}

variable "oms_agent_enable" {
  description = "Enable OMS Agent profile"
  default     = true
}

variable "enable_diagnostics" {
  default = false
  type    = bool
}

# Diagnostics
variable "log_analytics" {
  type = map(object({
    enabled = bool
    retention = object({
      enabled = bool
      days    = number
    })
  }))
  default = {}
}
variable "metrics" {
  type = map(object({
    enabled = bool
    retention = object({
      enabled = bool
      days    = number
    })
  }))
  default = {}
}

variable "private_cluster_enabled" {
  type    = bool
  default = false
}

variable "private_dns_zone_id" {
  type    = string
  default = null
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  default     = []
  description = "List of IPs to whitelist for incoming to Kubernetes API"
}

variable "azure_policy_enable" {
  type        = bool
  default     = false
  description = "Turn on Azure Policy in cluster or not"
}

variable "automatic_channel_upgrade" {
  type    = string
  default = null
}

# Ingress Application Gateway
variable "ingress_application_gateway_enable" {
  type    = bool
  default = false
}

variable "ingress_application_gateway_name" {
  type    = string
  default = null
}

variable "ingress_application_subnet_id" {
  type    = string
  default = null
}

variable "ingress_application_subnet_cidr" {
  type    = string
  default = null
}

variable "key_vault_secrets_provider" {
  type = map(object({
    secret_rotation_enabled  = string
    secret_rotation_interval = string
  }))

  default = null
}
