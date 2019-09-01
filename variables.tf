## Metadata ##
variable "environment" {
  description = "A name for the environment"
  default     = ""
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

variable "node_pools" {
  description = "Node pools to use"
  default     = []
  type        = list
}

variable "agent_count" {
  description = "Number of agents in k8s"
  default     = 2
}

variable "vm_size" {
  description = "Size of VMs in k8s cluster"
  default     = "Standard_D4_v3"
}

variable "admin_username" {
  description = "user name to add to VMs"
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "public key to add to admin_user in VMs"
}

variable "client_id" {
  description = "azure client id"
}

variable "client_secret" {
  description = "azure client secret"
}

## RBAC variables ##
variable "rbac_enable" {
  description = "Should RBAC be enabled."
  default     = true
}

variable "rbac_client_app_id" {
  description = "The Client ID of an Azure Active Directory Application"
}

variable "rbac_server_app_id" {
  description = "The Server ID of an Azure Active Directory Application"
}

variable "rbac_server_app_secret" {
  description = "The Client Secret of an Azure Active Directory Application"
}

#variable "rbac_tenant_id" {
#	description = "The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used"
#}

variable "load_balancer_sku" {
  default = "basic"
}

variable "aks_network_plugin" {
  default = "kubenet"
}

variable "aks_pod_cidr" {
  default = "10.244.0.0/16"
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