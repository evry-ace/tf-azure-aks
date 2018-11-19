## Metadata ##
variable "environment" {
  description = "A name for the environment"
  default     = "dev"
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
  default     = "1.11.2"
}

variable "cluster_name" {
  description = "What the k8s cluster should be identified as"
}

variable "dns_prefix" {
  description = ""
  default     = "${var.cluster-name}-${var.environment}"
}

variable "agent_count" {
  description = "Number of agents in k8s"
  default     = 2
}

variable "vm_size" {
  description = "Size of VMs in k8s cluster"
  default     = "Standard_D4"
}

variable "addon_http_routing" {
  description = ""
  default     = false
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

