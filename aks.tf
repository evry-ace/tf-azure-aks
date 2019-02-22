## AKS kubernetes cluster ##
resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = "${var.cluster_name}"
  location            = "${var.resource_group_location}"
  resource_group_name = "${var.resource_group_name}"
  dns_prefix          = "${var.dns_prefix}"

  kubernetes_version = "${var.k8s_version}"

  linux_profile {
    admin_username = "${var.admin_username}"

    ssh_key {
      key_data = "${var.ssh_public_key}"
    }
  }

  agent_pool_profile {
    name            = "default"
    count           = "${var.agent_count}"
    vm_size         = "${var.vm_size}"
    os_type         = "Linux"
    os_disk_size_gb = 50
  }

  service_principal {
    client_id     = "${var.client_id}"
    client_secret = "${var.client_secret}"
  }

  tags {
    Environment = "${var.environment}"
  }

  role_based_access_control {
    enabled = "${var.rbac_enable}"

    azure_active_directory {
      client_app_id     = "${var.rbac_client_app_id}"
      server_app_id     = "${var.rbac_server_app_id}"
      server_app_secret = "${var.rbac_server_app_secret}"

      #use current subscription .. tenant_id = "${var.rbac_tenant_id}"
    }
  }

  network_profile {
    network_plugin = "${var.aks_network_plugin}"
    pod_cidr = "${var.aks_pod_cidr}"
    service_cidr = "${var.aks_service_cidr}"
    dns_service_ip = "${var.aks_dns_service_ip}"
    docker_bridge_cidr =  "${var.aks_docker_bridge_cidr}"
  }
}
