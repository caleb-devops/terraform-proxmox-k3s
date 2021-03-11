output "kube_config" {
  description = "Generated kubeconfig"
  value       = try(module.k3s.kube_config, null)
  sensitive   = true
}

output "summary" {
  description = "Current state of k3s (version & nodes)"
  value       = try(module.k3s.summary, null)
}

output "kubernetes_ready" {
  description = "Dependency endpoint to synchronize k3s installation and provisioning."
  value       = try(module.k3s.kubernetes_ready, null)
}
