## Outputs ##
output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s_cluster.kube_admin_config_raw
  sensitive = true
}

output "kube_host" {
  value     = azurerm_kubernetes_cluster.k8s_cluster.kube_admin_config[0].host
  sensitive = true
}

output "kube_client_key" {
  value     = azurerm_kubernetes_cluster.k8s_cluster.kube_admin_config[0].client_key
  sensitive = true
}

output "kube_client_ca" {
  value     = azurerm_kubernetes_cluster.k8s_cluster.kube_admin_config[0].client_certificate
  sensitive = true
}

output "kube_cluster_ca" {
  value     = azurerm_kubernetes_cluster.k8s_cluster.kube_admin_config[0].cluster_ca_certificate
  sensitive = true
}

output "kube_configure" {
  value = <<CONFIGURE

Run the following commands to configure kubernetes client:

$ terraform output kube_config > ~/.kube/aksconfig
$ export KUBECONFIG=~/.kube/aksconfig

Test configuration using kubectl

$ kubectl get nodes
CONFIGURE

}

output "kubelet_identity" {
  value = azurerm_kubernetes_cluster.k8s_cluster.kubelet_identity
}

output "identity" {
  value = azurerm_kubernetes_cluster.k8s_cluster.identity
}

output "network_profile" {
  value = azurerm_kubernetes_cluster.k8s_cluster.network_profile
}

// Re-export the AKS name for usage
output "name" {
  value = var.cluster_name
}