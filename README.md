<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| proxmox | ~> 2.6.5 |

## Providers

| Name | Version |
|------|---------|
| local | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| k3s | xunleii/k3s/module | ~> 3.0 |
| k3s_agent | github.com/caleb-devops/terraform-proxmox-ci-vm |  |
| k3s_server | github.com/caleb-devops/terraform-proxmox-ci-vm |  |

## Resources

| Name |
|------|
| [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| agent\_cores | The number of CPU cores per CPU socket to allocate to the VM | `number` | `1` | no |
| agent\_count | The number of K3S agent nodes to create | `number` | n/a | yes |
| agent\_disks | VM disk config | `list(map(string))` | <pre>[<br>  {}<br>]</pre> | no |
| agent\_memory | The amount of memory to allocate to the VM in Megabytes | `number` | `512` | no |
| agent\_networks | VM network adapter config | `list(map(string))` | <pre>[<br>  {}<br>]</pre> | no |
| agent\_sockets | The number of CPU sockets to allocate to the VM | `number` | `1` | no |
| cipassword | Override the default cloud-init user's password | `string` | `null` | no |
| ciuser | Override the default cloud-init user for provisioning | `string` | n/a | yes |
| clone | The base VM from which to clone to create the new VM | `string` | n/a | yes |
| connection | Provisioner connection settings | `map(string)` | <pre>{<br>  "agent": true,<br>  "type": "ssh"<br>}</pre> | no |
| k3s\_version | Specify the k3s version. You can choose from the following release channels or pin the version directly | `string` | `"latest"` | no |
| kubeconfig\_file\_permission | File permission of the Kubectl config file containing cluster configuration saved to `kubeconfig_output_path.` | `string` | `"0600"` | no |
| kubeconfig\_output\_path | Where to save the Kubectl config file (if `write_kubeconfig = true`). Assumed to be a directory if the value ends with a forward slash `/`. | `string` | `"./"` | no |
| name\_prefix | Creates a name beginning with the specified prefix | `string` | n/a | yes |
| nameserver | Sets default DNS server for guest | `string` | `null` | no |
| numa | Whether to enable Non-Uniform Memory Access in the guest | `bool` | `false` | no |
| pool | The destination resource pool for the new VM | `string` | `null` | no |
| searchdomain | Sets default DNS search domain suffix | `string` | `null` | no |
| server\_cores | The number of CPU cores per CPU socket to allocate to the VM | `number` | `1` | no |
| server\_count | The number of K3S server nodes to create | `number` | n/a | yes |
| server\_disks | VM disk config | `list(map(string))` | <pre>[<br>  {}<br>]</pre> | no |
| server\_memory | The amount of memory to allocate to the VM in Megabytes | `number` | `512` | no |
| server\_networks | VM network adapter config | `list(map(string))` | <pre>[<br>  {}<br>]</pre> | no |
| server\_sockets | The number of CPU sockets to allocate to the VM | `number` | `1` | no |
| sshkeys | Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user | `string` | n/a | yes |
| target\_node | The name of the Proxmox Node on which to place the VM | `string` | `"pve"` | no |
| write\_kubeconfig | Whether to write a Kubectl config file containing the cluster configuration. Saved to `kubeconfig_output_path`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| kube\_config | kubectl config file contents |
| kubernetes\_ready | Dependency endpoint to synchronize k3s installation and provisioning. |
| summary | Current state of k3s (version & nodes) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->