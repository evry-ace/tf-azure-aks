variable "environment" {
  description = ""
  default = "dev"
}

variable "resource_group_name" {
  description = ""
}

## AKS and ACR variables ##
variable "k8s_version" {
  description = ""
  default = "1.11.2"
}

variable "cluster_name" {
  description = ""
}

variable "dns_prefix" {
  description = ""
  default = "${var.cluster-name}-${var.environment}"
}

variable "agent_count" {
  description = ""
  default = 2
}

variable "vm_size" {
  description = ""
  default = "Standard_D4"
}

variable "addon_http_routing" {
  description = ""
  default = false
}

variable "admin_username" {
  description = ""
  default = "azureuser"
}
