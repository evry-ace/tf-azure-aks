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
  default     = null
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

variable "msd_workspace_id" {
  description = "Specifies the ID of the Log Analytics Workspace where the audit logs collected by Microsoft Defender should be sent to"
  default     = ""
}

variable "msd_enable" {
  type        = bool
  description = "Enable audit logs collected by Microsoft Defender"
  default     = false
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

variable "node_os_channel_upgrade" {
  type        = string
  default     = "None"
  description = "automatically upgrades the node image to the latest version available."
}

variable "max_surge" {
  type        = string
  default     = "33%"
  description = "The maximum percentage of nodes which will be added to the Node Pool size during an upgrade"
}

variable "frequency" {
  description = "Frequency of maintenance."
  type        = string
  default     = "Weekly"
}

variable "interval" {
  description = "The interval for maintenance runs."
  type        = number
  default     = 1
}

variable "duration" {
  description = "The duration of the window for maintenance to run in hours."
  type        = string
  default     = "5"
}

variable "day_of_week" {
  description = "The day of the week for the maintenance run."
  type        = string
  default     = "Tuesday"
}

variable "maintenance_window_auto_upgrade" {
  type = object({
    day_of_month = optional(number)
    day_of_week  = optional(string)
    duration     = number
    frequency    = string
    interval     = number
    start_date   = optional(string)
    start_time   = optional(string)
    utc_offset   = optional(string)
    week_index   = optional(string)
    not_allowed = optional(map(object({
      end   = string
      start = string
    })))
  })
  default     = null
  description = <<-EOT
 - `day_of_month` - (Optional) The day of the month for the maintenance run. Required in combination with RelativeMonthly frequency. Value between 0 and 31 (inclusive).
 - `day_of_week` - (Optional) The day of the week for the maintenance run. Options are `Monday`, `Tuesday`, `Wednesday`, `Thurday`, `Friday`, `Saturday` and `Sunday`. Required in combination with weekly frequency.
 - `duration` - (Required) The duration of the window for maintenance to run in hours.
 - `frequency` - (Required) Frequency of maintenance. Possible options are `Weekly`, `AbsoluteMonthly` and `RelativeMonthly`.
 - `interval` - (Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
 - `start_date` - (Optional) The date on which the maintenance window begins to take effect.
 - `start_time` - (Optional) The time for maintenance to begin, based on the timezone determined by `utc_offset`. Format is `HH:mm`.
 - `utc_offset` - (Optional) Used to determine the timezone for cluster maintenance.
 - `week_index` - (Optional) The week in the month used for the maintenance run. Options are `First`, `Second`, `Third`, `Fourth`, and `Last`.

 ---
 `not_allowed` block supports the following:
 - `end` - (Required) The end of a time span, formatted as an RFC3339 string.
 - `start` - (Required) The start of a time span, formatted as an RFC3339 string.
EOT
}

variable "maintenance_window_node_os" {
  type = object({
    day_of_month = optional(number)
    day_of_week  = optional(string)
    duration     = number
    frequency    = string
    interval     = number
    start_date   = optional(string)
    start_time   = optional(string)
    utc_offset   = optional(string)
    week_index   = optional(string)
    not_allowed = optional(map(object({
      end   = string
      start = string
    })))
  })
  default     = null
  description = <<-EOT
 - `day_of_month` - (Optional) The day of the month for the maintenance run. Required in combination with RelativeMonthly frequency. Value between 0 and 31 (inclusive).
 - `day_of_week` - (Optional) The day of the week for the maintenance run. Options are `Monday`, `Tuesday`, `Wednesday`, `Thurday`, `Friday`, `Saturday` and `Sunday`. Required in combination with weekly frequency.
 - `duration` - (Required) The duration of the window for maintenance to run in hours.
 - `frequency` - (Required) Frequency of maintenance. Possible options are `Daily`, `Weekly`, `AbsoluteMonthly` and `RelativeMonthly`.
 - `interval` - (Required) The interval for maintenance runs. Depending on the frequency this interval is week or month based.
 - `start_date` - (Optional) The date on which the maintenance window begins to take effect.
 - `start_time` - (Optional) The time for maintenance to begin, based on the timezone determined by `utc_offset`. Format is `HH:mm`.
 - `utc_offset` - (Optional) Used to determine the timezone for cluster maintenance.
 - `week_index` - (Optional) The week in the month used for the maintenance run. Options are `First`, `Second`, `Third`, `Fourth`, and `Last`.

 ---
 `not_allowed` block supports the following:
 - `end` - (Required) The end of a time span, formatted as an RFC3339 string.
 - `start` - (Required) The start of a time span, formatted as an RFC3339 string.
EOT
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
variable "ingress_application_gateway_subnet_id" {
  type    = string
  default = null
}

variable "ingress_application_gateway_subnet_cidr" {
  type    = string
  default = null
}

variable "ingress_application_gateway_id" {
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
