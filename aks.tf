locals {
  default_pool_settings = {
    name               = "default"
    node_count         = 2
    vm_size            = "Standard_D3_v2"
    os_type            = "Linux"
    os_disk_size_gb    = 50
    default_pool_type  = "VirtualMachineScaleSets"
    min_count          = 1
    max_count          = 2
    availability_zones = []
    vnet_subnet_id     = var.aks_vnet_subnet_id
    max_pods           = 30
    priority           = "Regular"
    eviction_policy    = "Delete"
    k8s_version        = var.k8s_version
    node_labels        = {}
    node_taints        = []
    spot_max_price     = -1
  }

  node_pools = {
    for p in var.node_pools :
    p.name => {
      name               = p.name
      node_count         = lookup(p, "node_count", local.default_pool_settings.node_count)
      vm_size            = lookup(p, "vm_size", local.default_pool_settings.vm_size)
      os_type            = lookup(p, "os_type", local.default_pool_settings.os_type)
      os_disk_size_gb    = lookup(p, "os_disk_size_gb", local.default_pool_settings.os_disk_size_gb)
      vnet_subnet_id     = var.create_vnet ? element(concat(azurerm_subnet.k8s_agent_subnet.*.id, [""]), 0) : var.aks_vnet_subnet_id
      availability_zones = lookup(p, "availability_zones", local.default_pool_settings.availability_zones)

      mode                = lookup(p, "mode", "User")
      enable_auto_scaling = lookup(p, "enable_auto_scaling", true)
      min_count           = lookup(p, "min_count", lookup(p, "enable_auto_scaling", true) ? local.default_pool_settings.min_count : null)
      max_count           = lookup(p, "max_count", lookup(p, "enable_auto_scaling", true) ? local.default_pool_settings.max_count : null)
      tags                = lookup(p, "tags", var.tags)
      node_labels         = lookup(p, "node_labels", local.default_pool_settings.node_labels)
      node_taints         = lookup(p, "node_taints", local.default_pool_settings.node_taints)

      max_pods    = lookup(p, "max_pods", local.default_pool_settings.max_pods)
      k8s_version = lookup(p, "k8s_version", local.default_pool_settings.k8s_version)

      priority        = lookup(p, "priority", local.default_pool_settings.priority)
      eviction_policy = lookup(p, "eviction_policy", local.default_pool_settings.eviction_policy)
      spot_max_price  = lookup(p, "spot_max_price", local.default_pool_settings.spot_max_price)
    }
  }

  default_log_analytics = {
    "kube-controller-manager" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
    "kube-apiserver" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
    "cluster-autoscaler" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
    "guard" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
    "kube-apiserver" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
    "kube-audit" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
    "kube-audit-admin" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
    "kube-scheduler" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
  }
  default_metrics = {
    "AllMetrics" = {
      enabled   = false,
      retention = { enabled = false, days = 0 }
    }
  }
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
  count            = var.create_vnet ? 1 : 0
  address_prefixes = [var.aks_vnet_subnet_cidr]
}

resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                    = var.cluster_name
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  dns_prefix              = var.dns_prefix
  private_cluster_enabled = var.private_cluster_enabled
  kubernetes_version      = var.k8s_version

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = var.ssh_public_key
    }
  }

  node_resource_group = var.node_resource_group

  #if No aks_vnet_subnet_id is passed THEN use newly created subnet id ELSE use PASSED subnet id
  default_node_pool {
    name                 = "default"
    node_count           = lookup(var.default_pool, "node_count", local.default_pool_settings.node_count)
    vm_size              = lookup(var.default_pool, "vm_size", local.default_pool_settings.vm_size)
    os_disk_size_gb      = lookup(var.default_pool, "os_dize_size_gb", local.default_pool_settings.os_disk_size_gb)
    vnet_subnet_id       = var.create_vnet ? element(concat(azurerm_subnet.k8s_agent_subnet.*.id, [""]), 0) : var.aks_vnet_subnet_id
    availability_zones   = lookup(var.default_pool, "availability_zones", local.default_pool_settings.availability_zones)
    type                 = lookup(var.default_pool, "type", local.default_pool_settings.default_pool_type)
    enable_auto_scaling  = lookup(var.default_pool, "enable_auto_scaling", true)
    min_count            = lookup(var.default_pool, "min_count", lookup(var.default_pool, "enable_auto_scaling", true) ? local.default_pool_settings.min_count : null)
    max_count            = lookup(var.default_pool, "max_count", lookup(var.default_pool, "enable_auto_scaling", true) ? local.default_pool_settings.max_count : null)
    tags                 = lookup(var.default_pool, "tags", var.tags)
    max_pods             = lookup(var.default_pool, "max_pods", local.default_pool_settings.max_pods)
    orchestrator_version = lookup(var.default_pool, "k8s_version", local.default_pool_settings.k8s_version)
  }

  dynamic "service_principal" {
    for_each = var.identity_type == "SP" ? [1] : []

    content {
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }

  dynamic "identity" {
    for_each = var.identity_type != "SP" ? [1] : []

    content {
      type = var.identity_type
    }
  }

  role_based_access_control {
    enabled = var.rbac_enable

    azure_active_directory {
      managed                = var.rbac_managed
      admin_group_object_ids = var.rbac_admin_group_ids
      client_app_id          = var.rbac_managed == false ? var.rbac_client_app_id : null
      server_app_id          = var.rbac_managed == false ? var.rbac_server_app_id : null
      server_app_secret      = var.rbac_managed == false ? var.rbac_server_app_secret : null
      #use current subscription .. tenant_id = "${var.rbac_tenant_id}"
    }
  }

  network_profile {
    load_balancer_sku = var.load_balancer_sku
    outbound_type     = var.outbound_type

    network_plugin = var.aks_network_plugin
    network_policy = var.aks_network_policy

    pod_cidr           = var.aks_pod_cidr
    service_cidr       = var.aks_service_cidr
    dns_service_ip     = var.aks_dns_service_ip
    docker_bridge_cidr = var.aks_docker_bridge_cidr

    dynamic "load_balancer_profile" {
      for_each = var.outbound_type == "loadbalancer" ? [1] : []

      content {
        managed_outbound_ip_count = var.managed_outbound_ip_count
        outbound_ip_prefix_ids    = var.outbound_ip_prefix_ids
        outbound_ip_address_ids   = var.outbound_ip_address_ids
      }
    }
  }

  dynamic "addon_profile" {
    for_each = [1]

    content {
      kube_dashboard {
        enabled = false
      }

      dynamic "oms_agent" {
        for_each = var.oms_agent_enable ? [1] : []

        content {
          enabled                    = var.oms_agent_enable
          log_analytics_workspace_id = var.oms_workspace_id
        }
      }
    }
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "aks-node" {
  for_each = local.node_pools

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s_cluster.id

  node_count         = each.value.node_count
  vm_size            = each.value.vm_size
  os_disk_size_gb    = each.value.os_disk_size_gb
  vnet_subnet_id     = each.value.vnet_subnet_id
  availability_zones = each.value.availability_zones

  mode                = each.value.mode
  enable_auto_scaling = each.value.enable_auto_scaling
  min_count           = each.value.min_count
  max_count           = each.value.max_count
  tags                = each.value.tags
  node_labels         = each.value.node_labels
  node_taints         = each.value.node_taints

  max_pods             = each.value.max_pods
  orchestrator_version = each.value.k8s_version

  priority        = each.value.priority
  eviction_policy = each.value.eviction_policy
  spot_max_price  = each.value.spot_max_price
}

resource "azurerm_monitor_diagnostic_setting" "aks-diagnostics" {
  count                      = var.enable_diagnostics ? 1 : 0
  name                       = "diag-${var.cluster_name}"
  target_resource_id         = azurerm_kubernetes_cluster.k8s_cluster.id
  log_analytics_workspace_id = var.oms_workspace_id

  dynamic "log" {
    for_each = merge(local.default_log_analytics, var.log_analytics)

    content {
      category = log.key
      enabled  = log.value.enabled

      retention_policy {
        enabled = log.value.retention.enabled
        days    = log.value.retention.days
      }
    }
  }
  dynamic "metric" {
    #for_each = local.metrics
    for_each = merge(local.default_metrics, var.metrics)

    content {
      category = metric.key
      enabled  = metric.value.enabled

      retention_policy {
        enabled = metric.value.retention.enabled
        days    = metric.value.retention.days
      }
    }
  }
}
