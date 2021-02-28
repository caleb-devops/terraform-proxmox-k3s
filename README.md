<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14 |
| ansible | ~> 1.0.4 |
| proxmox | ~> 2.6.5 |

## Providers

| Name | Version |
|------|---------|
| ansible | ~> 1.0.4 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| k3s | github.com/caleb-devops/terraform-module-k3s |  |
| k3s_agent | github.com/caleb-devops/terraform-proxmox-ci-vm |  |
| k3s_server | github.com/caleb-devops/terraform-proxmox-ci-vm |  |

## Resources

| Name |
|------|
| [ansible_group](https://registry.terraform.io/providers/nbering/ansible/latest/docs/resources/group) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| agent\_cores | The number of CPU cores per CPU socket to allocate to the VM | `number` | `1` | no |
| agent\_count | The number of K3S agent nodes to create | `number` | n/a | yes |
| agent\_disks | VM disk config | `list(object({}))` | <pre>[<br>  {}<br>]</pre> | no |
| agent\_memory | The amount of memory to allocate to the VM in Megabytes | `number` | `512` | no |
| agent\_networks | VM network adapter config | `list(object({}))` | <pre>[<br>  {}<br>]</pre> | no |
| agent\_sockets | The number of CPU sockets to allocate to the VM | `number` | `1` | no |
| cipassword | Override the default cloud-init user's password | `string` | `null` | no |
| ciuser | Override the default cloud-init user for provisioning | `string` | n/a | yes |
| clone | The base VM from which to clone to create the new VM | `string` | n/a | yes |
| connection | Provisioner connection settings | `object({})` | <pre>{<br>  "agent": true,<br>  "type": "ssh"<br>}</pre> | no |
| name\_prefix | Creates a name beginning with the specified prefix | `string` | n/a | yes |
| nameserver | Sets default DNS server for guest | `string` | `null` | no |
| numa | Whether to enable Non-Uniform Memory Access in the guest | `bool` | `false` | no |
| pool | The destination resource pool for the new VM | `string` | `null` | no |
| searchdomain | Sets default DNS search domain suffix | `string` | `null` | no |
| server\_cores | The number of CPU cores per CPU socket to allocate to the VM | `number` | `1` | no |
| server\_count | The number of K3S server nodes to create | `number` | n/a | yes |
| server\_disks | VM disk config | `list(object({}))` | <pre>[<br>  {}<br>]</pre> | no |
| server\_memory | The amount of memory to allocate to the VM in Megabytes | `number` | `512` | no |
| server\_networks | VM network adapter config | `list(object({}))` | <pre>[<br>  {}<br>]</pre> | no |
| server\_sockets | The number of CPU sockets to allocate to the VM | `number` | `1` | no |
| sshkeys | Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user | `string` | n/a | yes |
| target\_node | The name of the Proxmox Node on which to place the VM | `string` | `"pve"` | no |

## Outputs

| Name | Description |
|------|-------------|
| kube\_config | Genereated kubeconfig |
| kubernetes | Authentication credentials of Kubernetes (full administrator) |
| kubernetes\_ready | Dependency endpoint to synchronize k3s installation and provisioning. |
| summary | Current state of k3s (version & nodes) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->