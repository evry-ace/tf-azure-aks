locals {
  env = var.environment != "" ? var.environment : terraform.workspace

  default_pool = {
    name            = "default"
    count           = var.agent_count
    vm_size         = var.vm_size
    os_type         = "Linux"
    os_disk_size_gb = 50
    subnet_id       = var.create_vnet ? element(concat(azurerm_subnet.k8s_agent_subnet.*.id, [""]), 0) : var.aks_vnet_subnet_id
  }

  node_pools = length(var.node_pools) == 0 ? [local.default_pool] : var.node_pools
}

resource "azurerm_virtual_network" "k8s_agent_network" {
  name                = "agent-net"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = [var.aks_vnet_subnet_cidr]

  count = var.create_vnet ? 1 : 0
}

resource "azurerm_subnet" "k8s_agent_subnet" {
  name                 = "agent-subnet"
  virtual_network_name = azurerm_virtual_network.k8s_agent_network[0].name
  resource_group_name  = var.resource_group_name

  # IF aks_vnet_subnet_id (NO Subnet is passed) CREATE this SUBNET ELSE DONT
  count          = var.create_vnet ? 1 : 0
  address_prefix = var.aks_vnet_subnet_cidr

  lifecycle {
    ignore_changes = [
      route_table_id,
      network_security_group_id,
    ]
  }
}

resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = var.cluster_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  kubernetes_version = var.k8s_version

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  #if No aks_vnet_subnet_id is passed THEN use newly created subnet id ELSE use PASSED subnet id
  dynamic "agent_pool_profile" {
    for_each = local.node_pools

    content {
      name            = agent_pool_profile.value.name
      count           = agent_pool_profile.value.count
      vm_size         = agent_pool_profile.value.vm_size
      os_type         = agent_pool_profile.value.os_type
      os_disk_size_gb = agent_pool_profile.value.os_disk_size_gb
      # type            = agent_pool_profile.value.type
      vnet_subnet_id = agent_pool_profile.value.subnet_id
    }
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = local.env
  }

  role_based_access_control {
    enabled = var.rbac_enable

    azure_active_directory {
      client_app_id     = var.rbac_client_app_id
      server_app_id     = var.rbac_server_app_id
      server_app_secret = var.rbac_server_app_secret
      #use current subscription .. tenant_id = "${var.rbac_tenant_id}"
    }
  }

  network_profile {
    network_plugin     = var.aks_network_plugin
    pod_cidr           = var.aks_pod_cidr
    service_cidr       = var.aks_service_cidr
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr
  }

  dynamic "addon_profile" {
    for_each = var.oms_agent_enable ? [1] : []

    content {
      dynamic "oms_agent" {
        for_each = var.oms_agent_enable ? [1] : []

        content {
          enabled                    = var.oms_agent_enable
          log_analytics_workspace_id = var.oms_workspace_id
        }
      }
    }
  }
}

output "k8s_cluster" {
  value = azurerm_kubernetes_cluster.k8s_cluster
}
