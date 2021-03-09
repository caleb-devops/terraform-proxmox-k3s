<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| proxmox | ~> 2.6.5 |

## Providers

No provider.

## Modules

| Name | Source | Version |
|------|--------|---------|
| k3s_cluster | ../.. |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| pm\_api\_url | The Proxmox API URL | `string` | n/a | yes |
| pm\_password | The Proxmox password | `string` | n/a | yes |
| pm\_user | The Proxmox username | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| kube\_config | Generated kubeconfig |
| kubernetes | Authentication credentials of Kubernetes (full administrator) |
| kubernetes\_ready | Dependency endpoint to synchronize k3s installation and provisioning. |
| summary | Current state of k3s (version & nodes) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->