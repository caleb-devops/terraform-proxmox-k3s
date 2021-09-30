variable "target_node" {
  description = "The name of the Proxmox Node on which to place the VM"
  type        = string
  default     = "pve"
}

variable "pool" {
  description = "The destination resource pool for the new VM"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Creates a name beginning with the specified prefix"
  type        = string
}

variable "connection" {
  description = "Provisioner connection settings"
  type        = map(string)
  sensitive   = true
  default = {
    type  = "ssh"
    agent = true
  }
}

variable "k3s_version" {
  description = "Specify the k3s version. You can choose from the following release channels or pin the version directly"
  type        = string
  default     = "latest"
}

variable "kubeconfig_output_path" {
  description = "Where to save the Kubectl config file (if `write_kubeconfig = true`). Assumed to be a directory if the value ends with a forward slash `/`."
  type        = string
  default     = "./"
}

variable "kubeconfig_file_permission" {
  description = "File permission of the Kubectl config file containing cluster configuration saved to `kubeconfig_output_path.`"
  type        = string
  default     = "0600"
}

variable "write_kubeconfig" {
  description = "Whether to write a Kubectl config file containing the cluster configuration. Saved to `kubeconfig_output_path`."
  type        = bool
  default     = true
}

#####################################################
# VM Qemu Resource
#####################################################

variable "clone" {
  description = "The base VM from which to clone to create the new VM"
  type        = string
}

variable "numa" {
  description = "Whether to enable Non-Uniform Memory Access in the guest"
  type        = bool
  default     = false
}

variable "ciuser" {
  description = "Override the default cloud-init user for provisioning"
  type        = string
}

variable "cipassword" {
  description = "Override the default cloud-init user's password"
  type        = string
  sensitive   = true
  default     = null
}

variable "searchdomain" {
  description = "Sets default DNS search domain suffix"
  type        = string
  default     = null
}

variable "nameserver" {
  description = "Sets default DNS server for guest"
  type        = string
  default     = null
}

variable "sshkeys" {
  description = "Newline delimited list of SSH public keys to add to authorized keys file for the cloud-init user"
  type        = string
}

############################
# K3S Server
############################

variable "server_count" {
  description = "The number of K3S server nodes to create"
  type        = number
}

variable "server_cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM"
  type        = number
  default     = 1
}

variable "server_sockets" {
  description = "The number of CPU sockets to allocate to the VM"
  type        = number
  default     = 1
}

variable "server_memory" {
  description = "The amount of memory to allocate to the VM in Megabytes"
  type        = number
  default     = 512
}

variable "server_disks" {
  description = "VM disk config"
  type        = list(map(string))
  default     = [{}]
}

variable "server_networks" {
  description = "VM network adapter config"
  type        = list(map(string))
  default     = [{}]
}

############################
# K3S Agent
############################

variable "agent_count" {
  description = "The number of K3S agent nodes to create"
  type        = number
}

variable "agent_cores" {
  description = "The number of CPU cores per CPU socket to allocate to the VM"
  type        = number
  default     = 1
}

variable "agent_sockets" {
  description = "The number of CPU sockets to allocate to the VM"
  type        = number
  default     = 1
}

variable "agent_memory" {
  description = "The amount of memory to allocate to the VM in Megabytes"
  type        = number
  default     = 512
}

variable "agent_disks" {
  description = "VM disk config"
  type        = list(map(string))
  default     = [{}]
}

variable "agent_networks" {
  description = "VM network adapter config"
  type        = list(map(string))
  default     = [{}]
}
