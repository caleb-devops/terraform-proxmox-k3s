output "kube_config" {
  description = "kubectl config file contents"
  value       = module.k3s_cluster.kube_config
  sensitive   = true
}

output "summary" {
  description = "Current state of k3s (version & nodes)"
  value       = module.k3s_cluster.summary
}

output "kubernetes_ready" {
  description = "Dependency endpoint to synchronize k3s installation and provisioning."
  value       = module.k3s_cluster.kubernetes_ready
}
