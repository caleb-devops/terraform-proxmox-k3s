output "kubernetes" {
  description = "Authentication credentials of Kubernetes (full administrator)"
  value       = module.k3s.kubernetes
  sensitive   = true
}

output "kube_config" {
  description = "Generated kubeconfig"
  value       = module.k3s.kube_config
  sensitive   = true
}

output "summary" {
  description = "Current state of k3s (version & nodes)"
  value       = module.k3s.summary
}

output "kubernetes_ready" {
  description = "Dependency endpoint to synchronize k3s installation and provisioning."
  value       = module.k3s.kubernetes_ready
}
